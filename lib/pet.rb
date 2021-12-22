require ('pry')

class Pet
  attr_accessor :id, :name, :gender, :date, :type, :breed

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @gender = attributes.fetch(:gender)
    @date = attributes.fetch(:date)
    @type = attributes.fetch(:type)
    @breed = attributes.fetch(:breed)
    @id = attributes.fetch(:id)
  end

  def self.all
    returned_pets = DB.exec("SELECT * FROM pets;")
    pets = []
    returned_pets.each() do |pet|
      name = pet.fetch("name")
      gender = pet.fetch("gender")
      type = pet.fetch("type")
      breed = pet.fetch("breed")
      date = pet.fetch("date").to_s
      id = pet.fetch("id").to_i
      pets.push(Pet.new({:name => name, :gender => gender, :date => date, :type => type, :breed => breed, :id => id}))
    end
    pets
  end

  def save
    result = DB.exec("INSERT INTO pets (name, gender, date, type, breed) VALUES ('#{@name}', '#{@gender}', '#{@date}', '#{@type}', '#{@breed}') RETURNING id;") # update
    @id = result.first().fetch("id").to_i
  end

  def ==(pet_to_compare)
    (self.name == pet_to_compare.name) && (self.gender == pet_to_compare.gender) && (self.date == pet_to_compare.date) && (self.type == pet_to_compare.type) && (self.breed == pet_to_compare.breed)
  end

  def self.clear
    DB.exec("DELETE FROM pets *;")
  end

  def self.find(id)
    pet = DB.exec("SELECT * FROM pets WHERE id = #{id};").first # update
    name = pet.fetch("name")
    gender = pet.fetch("gender")
    date = pet.fetch("date")
    type = pet.fetch("type")
    breed = pet.fetch("breed")
    id = pet.fetch("id").to_i
    Pet.new({:name => name, :gender => gender, :date => date, :type => type, :breed => breed, :id => id})
  end

  def update(attributes) # update for all attributes
    if (attributes.has_key?(:name)) && (attributes.fetch(:name) != nil)
      @name = attributes.fetch(:name)
    end
    if attributes.has_key?(:gender) && (attributes.fetch(:gender) != nil)
      @gender = attributes.fetch(:date) 
    end
    if attributes.has_key?(:type) && (attributes.fetch(:type) != nil)
      @type = attributes.fetch(:type) 
    end
    if attributes.has_key?(:breed) && (attributes.fetch(:breed) != nil)
      @breed = attributes.fetch(:breed) 
    end
    if attributes.has_key?(:date) && (attributes.fetch(:date) != nil)
      @breed = attributes.fetch(:date) 
    end
    DB.exec("UPDATE pets SET name='#{@name}', gender='#{@gender}', date='#{@date}', type='#{@type}', breed='#{@breed}' WHERE id = #{@id};")
  end

  def delete # update
    DB.exec("DELETE FROM pets WHERE id = #{@id};")
  end

  # def self.sort
  #   array = @@pets.values.sort_by! &:name
  #   @@pets = {}
  #   array.each do |element|
  #     @@pets[element.id] = element
  #   end
  # end

  def customers
    Customer.find_by_pet(self.id)
  end
end