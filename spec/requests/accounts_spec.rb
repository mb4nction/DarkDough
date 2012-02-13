require 'spec_helper'

describe "Accounts" do
  before :each do
    @user = Factory(:user)
    @bank = Factory(:bank)
    @account = Factory(:account, :user => @user, :bank => @bank)
    visit user_session_path
    fill_in 'Email',    :with => "johny@mailinator.com"
    fill_in 'Password', :with => "password"
    click_button
  end

  describe "GET /accounts" do
    it "should be success" do
      get accounts_path
      response.should be_success
      response.should have_selector(:h1, :content => "Accounts")
      response.should have_selector(:a, :content => "New Account", :href => "/accounts/new")
    end
  end
end
