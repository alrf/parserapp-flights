# -*- encoding : utf-8 -*-
class Flight < ActiveRecord::Base
  attr_accessible :arrival_airport, :date, :departure_airport, :econom, :fl

  belongs_to  :from_airport,   :class_name => "Airport", :foreign_key => 'departure_airport'
  belongs_to  :to_airport,   :class_name => "Airport", :foreign_key => 'arrival_airport'

  def to_xml(options = {})
    options.merge!(:only => [:date, :fl, :econom])
    super(options) do |xml|
      xml.airports from_airport.name + '-' + to_airport.name
    end
  end

  # пишем в базу
  def self.writeDB(arr)
    arr.each do |el|
      # пишем аэропорты, если таких еще нет
      Airport.find_or_create_by_name(:name => el[4]).save
      Airport.find_or_create_by_name(:name => el[6]).save

      # проверяем записи по всем полям
      # пишем полеты "туда", если таких еще нет
      from_conditions = {
          :departure_airport => Airport.find_by_name(el[4]).id,
          :arrival_airport => Airport.find_by_name(el[6]).id,
          :date => el[0].split[0],
          :econom => el[8],
          :fl => el[1]
      }
      Flight.where(from_conditions).first || Flight.create(from_conditions)

      # пишем полеты "обратно", если таких еще нет
      to_conditions = {
          :departure_airport => Airport.find_by_name(el[12]).id,
          :arrival_airport => Airport.find_by_name(el[14]).id,
          :date => el[0].split[0],
          :econom => el[16],
          :fl => el[9]
      }
      Flight.where(to_conditions).first || Flight.create(to_conditions)
    end
  end

  # показываем результаты
  def self.showResult(date_start, date_stop)
    return Flight.where(:date => date_start..date_stop)
  end

end
