require 'rails_helper'

describe User, type: :model do
  it 'is not valid without a name' do
    user = User.new(name: nil)
    expect(user).to_not be_valid
  end

  it 'is not valid if posts_counter is not an integer greater than or equal to zero' do
    user = User.new(posts_counter: -1)
    expect(user).to_not be_valid
  end

  it 'is valid if posts_counter is an integer greater than or equal to zero' do
    user = User.new(posts_counter: 0)
    expect(user).to be_valid
  end
end
