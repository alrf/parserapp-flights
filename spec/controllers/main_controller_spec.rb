# -*- encoding : utf-8 -*-
require 'spec_helper'
require 'rest_client'
require 'webmock'
include WebMock::API

describe MainController do

  before (:each) do
    @m = MainController.new
    @url = 'http://online.nectravel.ru/freight_monitor?samo_action=FREIGHTS&TOWNFROMINC=2&STATEINC=3&TOWNTOINC=5&CHECKIN=20130320&NIGHTS_FROM=2'
    @content = "<script charset=\"windows-1251\" type=\"text/javascript\">(function(){if (typeof samo === \"undefined\") { samo = {}; }samo.ROOT_URL = '/freight_monitor?';samo.jQuery(samo.controls.resultset).ehtml('<table class=\"res\">\n\ <thead>\n\ <tr>\n\ <th>Вылет</th>\n\ <th>Рейс туда</th>\n\ <th>Транспорт</th>\n\ <th>А/К</th>\n\ <th>А/П</th>\n\ <th>Время</th>\n\ <th>А/П</th>\n\ <th>Время</th>\n\ <th>Эконом</th> <td class=\"splitter\">&nbsp;</td>\n\ <th>Рейс обратно</th>\n\ <th>Транспорт</th>\n\ <th>А/К</th>\n\ <th>А/П</th>\n\ <th>Время</th>\n\ <th>А/П</th>\n\ <th>Время</th>\n\ <th>Эконом</th> </tr>\n\ </thead>\n\ <tbody>\n\ <tr>\n\ <td class=\"freight_1\">24.03.2013, Вс</td>\n\ <td class=\"freight_1\">H5 9649</td>\n\ <td class=\"freight_1\">BOEING-757-200</td>\n\ <td class=\"freight_1\">I FLY</td>\n\ <td class=\"freight_1\">VKO-B</td>\n\ <td class=\"freight_1\">18:25</td>\n\ <td class=\"freight_1\">IST</td>\n\ <td class=\"freight_1\">19:40</td>\n\ <td class=\"noplace\">\n\ нет </td>\n\ <td class=\"splitter\">&nbsp;</td>\n\ \n\ <td class=\"default\">H5 9650</td>\n\ <td class=\"default\">BOEING-757-200</td>\n\ <td class=\"default\">I FLY</td>\n\ <td class=\"default\">IST</td>\n\ <td class=\"default\">21:30</td>\n\ <td class=\"default\">VKO-B</td>\n\ <td class=\"default\">02:50<span class=\"delta\">+1</span></td>\n\ <td class=\"noplace\">\n\ нет </td>\n\ </tr>\n\ <tr>\n\ <td class=\"default\">26.03.2013, Вт</td>\n\ <td class=\"default\">H5 9649</td>\n\ <td class=\"default\">BOEING-757-200</td>\n\ <td class=\"default\">I FLY</td>\n\ <td class=\"default\">VKO-B</td>\n\ <td class=\"default\">18:25</td>\n\ <td class=\"default\">IST</td>\n\ <td class=\"default\">19:40</td>\n\ <td class=\"yesplace\">\n\ есть </td>\n\ <td class=\"splitter\">&nbsp;</td>\n\ \n\ <td class=\"freight_1\">H5 9650</td>\n\ <td class=\"freight_1\">BOEING-757-200</td>\n\ <td class=\"freight_1\">I FLY</td>\n\ <td class=\"freight_1\">IST</td>\n\ <td class=\"freight_1\">21:30</td>\n\ <td class=\"freight_1\">VKO-B</td>\n\ <td class=\"freight_1\">02:50<span class=\"delta\">+1</span></td>\n\ <td class=\"noplace\">\n\ нет </td>\n\ </tr>\n\ </tbody>\n\ </table>\n\ '); if (typeof samo != \"undefined\" && typeof samo.page_callback != \"undefined\") {samo.page_callback('freight_monitor','FREIGHTS',{'TOWNFROMINC':2,'STATEINC':3});};})();</script>"
    @str = '<table class="res"><thead><tr><th>Вылет</th><th>Рейс туда</th><th>Транспорт</th><th>А/К</th><th>А/П</th><th>Время</th><th>А/П</th><th>Время</th><th>Эконом</th><td class="splitter">&nbsp;</td><th>Рейс обратно</th><th>Транспорт</th><th>А/К</th><th>А/П</th><th>Время</th><th>А/П</th><th>Время</th><th>Эконом</th></tr></thead><tbody><tr><td class="freight_1">24.03.2013 Вс</td><td class="freight_1">H5 9649</td><td class="freight_1">BOEING-757-200</td><td class="freight_1">I FLY</td><td class="freight_1">VKO-B</td><td class="freight_1">18:25</td><td class="freight_1">IST</td><td class="freight_1">19:40</td><td class="noplace"> нет </td><td class="splitter">&nbsp;</td><td class="default">H5 9650</td><td class="default">BOEING-757-200</td><td class="default">I FLY</td><td class="default">IST</td><td class="default">21:30</td><td class="default">VKO-B</td><td class="default">02:50<span class="delta">+1</span></td><td class="noplace"> нет </td></tr><tr><td class="default">26.03.2013 Вт</td><td class="default">H5 9649</td><td class="default">BOEING-757-200</td><td class="default">I FLY</td><td class="default">VKO-B</td><td class="default">18:25</td><td class="default">IST</td><td class="default">19:40</td><td class="yesplace"> есть </td><td class="splitter">&nbsp;</td><td class="freight_1">H5 9650</td><td class="freight_1">BOEING-757-200</td><td class="freight_1">I FLY</td><td class="freight_1">IST</td><td class="freight_1">21:30</td><td class="freight_1">VKO-B</td><td class="freight_1">02:50<span class="delta">+1</span></td><td class="noplace"> нет </td></tr></tbody></table>'
    @ar = [["24.03.2013 Вс", "H5 9649", "BOEING-757-200", "I FLY", "VKO-B", "18:25", "IST", "19:40", "нет", "H5 9650", "BOEING-757-200", "I FLY", "IST", "21:30", "VKO-B", "02:50<span class=\"delta\">+1</span>", "нет"], ["26.03.2013 Вт", "H5 9649", "BOEING-757-200", "I FLY", "VKO-B", "18:25", "IST", "19:40", "есть", "H5 9650", "BOEING-757-200", "I FLY", "IST", "21:30", "VKO-B", "02:50<span class=\"delta\">+1</span>", "нет"]]
    stub_request(:get, @url).to_return(:body => @content)
  end

  it "check request to operator" do
    date_start = Date.parse('20.03.2013')
    date_stop = Date.parse('22.03.2013')
    difference_day = (date_stop - date_start).to_i
    date_start_url = date_start.strftime('%Y%m%d')
    url = 'http://online.nectravel.ru/freight_monitor?samo_action=FREIGHTS&TOWNFROMINC=2&STATEINC=3&TOWNTOINC=5&CHECKIN=' + date_start_url + '&NIGHTS_FROM=' + difference_day.to_s
    @m.remoteConnect(url)
    WebMock.should have_requested(:get, url)
  end

  it "check remoteConnect, we should get full content" do
    @m.remoteConnect(@url).should == @content.encode('utf-8', 'windows-1251')
  end

  it "check getData" do
    rc = @m.remoteConnect(@url)
    gd = @m.getData(rc)
    gd.should == @str.encode('utf-8', 'windows-1251')
  end

  it "check parserData" do
    pd = @m.parserData(@str)
    pd.should == @ar
  end

end
