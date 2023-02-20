require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it "should save a product with all four fields set" do
      @category = Category.create(name: 'Succulents')
      @category.save

      @product = Product.new
      @product.name = 'Aloe Vera'
      @product.price = 50
      @product.quantity = 6
      @product.category_id = @category.id
      @product.save

      expect(@product).to be_valid
    end

    it "should not save a product without a name" do
      @category = Category.create(name: 'Succulents')
      @category.save

      @product = Product.new
      @product.name = nil
      @product.price = 50
      @product.quantity = 6
      @product.category_id = @category.id
      @product.save

      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it "should not save a product without a price" do
      @category = Category.create(name: 'Succulents')
      @category.save

      @product = Product.new
      @product.name = "Aloe Vera"
      @product.quantity = 6
      @product.category_id = @category.id
      @product.save

      expect(@product).to_not be_valid
    end

    it "should not save a product without a quantity" do
      @category = Category.create(name: 'Succulents')
      @category.save

      @product = Product.new
      @product.name = nil
      @product.price = 50
      @product.quantity = nil
      @product.category_id = @category.id
      @product.save

      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it "should not save a product without a quantity" do
      @category = Category.create(name: 'Succulents')
      @category.save

      @product = Product.new
      @product.name = nil
      @product.price = 50
      @product.quantity = 6
      @product.category_id = nil
      @product.save

      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  

  end
end