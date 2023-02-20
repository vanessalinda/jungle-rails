require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "should create a new user with email, first name and last name fields filled and password and password_confirmation fields should match" do

      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')

      expect(@user).to be_valid
    end

    it "should not create a new user if the password and password_confirmation fields do not match" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-boo')

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "should not create a new user if the password field is blank" do      
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: nil, password_confirmation: nil)

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end  


    it "should not create a new user if the email is not unique" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')

      @user2 = User.new(first_name: 'Sam', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')
      @user2.save

      expect(@user2).to_not be_valid
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end  

    it "should not create a new user if the password does not meet the minimum length" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: '1', password_confirmation: '1')

      expect(@user).to_not be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 5 characters)")
    end  
  end

  describe '.authenticate_with_credentials' do
    it "should not authenticate (login) user if the password does not match" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')

      expect(User.authenticate_with_credentials('test@test.com', 'jungle-boo')).to be nil
    end
    
    it "should authenticate user if the password does match" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')

      expect(User.authenticate_with_credentials('test@test.com', 'jungle-book')).to eq(@user)
    end  

    it "should authenticate user if the password matches and the visitor types spaces before and/or after their email address" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')

      expect(User.authenticate_with_credentials(' test@test.com ', 'jungle-book')).to eq(@user)
    end  

    it "should authenticate user if the password matches and the visitor types in the wrong case for their email" do
      @user = User.create(first_name: 'Samantha', last_name: 'Power', email: 'test@test.com', password: 'jungle-book', password_confirmation: 'jungle-book')

      expect(User.authenticate_with_credentials('test@test.com', 'jungle-book')).to eq(@user)
    end  
  end
end