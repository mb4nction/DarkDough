require 'spec_helper'

describe UsersController do
  render_views

  before :each do
    @user = Factory(:user)
    sign_in @user
  end

  describe "#show" do
    it "should be success" do
      get :show, :id => @user
      response.should be_success
    end

    it "should find the right user" do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it "should include the user's first name" do
      get :show, :id => @user
      response.should have_selector(".block", :content => @user.first_name)
    end

    it "should include the user's last name" do
      get :show, :id => @user
      response.should have_selector(".block", :content => @user.last_name)
    end

    it "should include the user's email" do
      get :show, :id => @user
      response.should have_selector(".block", :content => @user.email)
    end

    it "should include the user's phone number" do
      get :show, :id => @user
      response.should have_selector(".block", :content => @user.phone_number)
    end

    it "should include the user's phone country" do
      get :show, :id => @user
      response.should have_selector(".block", :content => @user.country)
    end

  end
end
