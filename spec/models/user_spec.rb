require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(create(:user)).to be_valid
  end

  it "is invalid if has no password" do
    expect{
    create(:user, password: '')
    }.to raise_error(ActiveRecord::RecordInvalid, /Password can't be blank/)
  end

  it "is invalid if username already exists" do
  	original_user = create(:user)
    expect{
    create(:user, username: original_user.username)
    }.to raise_error(ActiveRecord::RecordInvalid, /Username has already been taken/)
  end
  
end