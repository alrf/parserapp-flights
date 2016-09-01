collection @arr, :object_root => false
attributes :date, :fl, :econom
node :airports do |s|
    s.from_airport.name + '-' + s.to_airport.name
end
