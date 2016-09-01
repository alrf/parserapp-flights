# -*- encoding : utf-8 -*-
require 'rest_client'
require 'hpricot'
WebMock.allow_net_connect!

class MainController < ApplicationController
  respond_to :html, :xml, :json

  def index
    @url = 'http://online.nectravel.ru/freight_monitor'

    # нажата кнопка Парсить
    unless params[:commit].nil?

      @arr = main(params[:date_start], params[:date_stop])

      respond_to do |format|
        format.html
        format.json { render "main/index.json.rabl" }
        format.xml { render "main/index.json.rabl" }
      end

    end
  end

  def main(date_start, date_stop)

    date_start = Date.parse(date_start)
    date_stop = Date.parse(date_stop)
    difference_day = (date_stop - date_start).to_i
    date_start_url = date_start.strftime('%Y%m%d')
    url = @url + '?samo_action=FREIGHTS&TOWNFROMINC=2&STATEINC=3&TOWNTOINC=5&CHECKIN=' + date_start_url + '&NIGHTS_FROM=' + difference_day.to_s

    @content = remoteConnect(url)
    @data = getData(@content)
    @arr = parserData(@data)
    Flight.writeDB(@arr)
    return Flight.showResult(date_start.strftime('%d.%m.%Y'), date_stop.strftime('%d.%m.%Y'))
  end

  # получаем контент
  def remoteConnect(url)
    RestClient.proxy = ENV['HTTP_PROXY']
    return RestClient.get(url).body.encode('utf-8', 'windows-1251')
  end

  # берем только нужный контент
  def getData(request)
    request =~ /ehtml\('(.*)'\);/m
    request = $1.gsub(/\n|\\n|\\n\\|\\|,/m, '')
    request = request.gsub(/>\s+</, '><').strip
    return request
  end

  # парсим контент
  def parserData(data)
    arr = []
    Hpricot(data).search("//table[@class='res']/tbody/tr").each { |tr_item|
      r = ''
      tr_item.search("//td").each { |td_item|
        r = r + '|' + td_item.innerHTML.gsub('&nbsp;', '')
      }
      arr.push r.split('|').reject(&:empty?).compact.collect(&:strip)
    }
    return arr
  end

end
