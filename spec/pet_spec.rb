require 'pet'
require 'spec_helper'

describe '#Pet' do

  describe('.all') do
    it("returns an empty array when there are no albums") do
      expect(Pet.all).to(eq([]))
    end
  end

  describe('#save') do
    it("saves an pet") do
      pet = Pet.new({:name => "Sassy", :gender => "Female", :date => '2019-10-11 00:00:00', :type => "Cat", :breed => "orange cat", :id => nil}) 
      pet.save()
      pet2 = Pet.new({:name => "Houser", :gender => "Male", :type => "Dog", :breed => "Golden Retriever", :date => '2009-02-09 00:00:00', :id => nil})
      pet2.save()
      expect(Pet.all).to(eq([pet, pet2]))
    end
  end

  describe('#==') do
    it("is the same pet if it has the same attributes as another pet") do
      pet = Pet.new({:name => "Sassy", :gender => "Female", :date => '2019-10-11 00:00:00', :type => "Cat", :breed => "orange cat", :id => nil}) 
      pet.save()
      pet2 = Pet.new({:name => "Sassy", :gender => "Female", :date => '2019-10-11 00:00:00', :type => "Cat", :breed => "orange cat", :id => nil}) 
      pet2.save()
      expect(pet).to(eq(pet2))
    end
  end

  describe('.clear') do
    it("clears all pets") do
      pet = Pet.new({:name => "Sassy", :gender => "Female", :date => '2019-10-11 00:00:00', :type => "Cat", :breed => "orange cat", :id => nil})
      pet.save()
      pet2 = Pet.new({:name => "Houser", :gender => "Male", :type => "Dog", :breed => "Golden Retriever", :date => '2009-02-09 00:00:00', :id => nil})
      pet2.save()
      Pet.clear()
      expect(Pet.all).to(eq([]))
    end
  end

  describe('.find') do
    it("finds an pet by id") do
      pet = Pet.new({:name => "Sassy", :gender => "Female", :date => '2019-10-11 00:00:00', :type => "Cat", :breed => "orange cat", :id => nil})
      pet.save()
      pet2 = Pet.new({:name => "Houser", :gender => "Male", :type => "Dog", :breed => "Golden Retriever", :date => '2009-02-09 00:00:00', :id => nil})
      pet2.save()
      expect(Pet.find(pet.id)).to(eq(pet))
    end
  end

  describe('#update') do
    it("updates an pet by id") do
      pet = Pet.new({:name => "Sassy", :gender => "Female", :date => '2019-10-11 00:00:00', :type => "Cat", :breed => "orange cat", :id => nil})
      pet.save()
      pet.update({:name => "Blue"}) # update for all attributes
      expect(pet.name).to(eq("Blue"))
    end
  end

  # describe('#delete') do
  #   it("deletes an pet by id") do
  #     pet = Pet.new({:name => "Giant Steps", :gender => "Jazz", :year => 1960, :id => nil})
  #     pet.save()
  #     pet2 = Pet.new({:name => "Blue", :gender => "Jazz", :year => 1960, :id => nil})
  #     pet2.save()
  #     pet.delete()
  #     expect(Pet.all).to(eq([pet2]))
  #   end
  # end


end