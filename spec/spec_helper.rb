require 'rspec'
require 'pg'
require 'pet'
require 'customer'
require 'pry'

DB = PG.connect({:dbname => 'animal_shelter_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM pets *;")
    DB.exec("DELETE FROM customers*;")
    DB.exec("DELETE FROM customers_pets*;")
  end
end