# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  token           :string(255)
#  display_name    :string(255)
#

require 'spec_helper'

describe User do
  let(:user) { create :user }

  it 'has a valid mock' do
    build(:user).should be_valid
  end

  it { should allow_mass_assignment_of :email }
  it { should allow_mass_assignment_of :password }
  it { should allow_mass_assignment_of :password_confirmation }
  it { should allow_mass_assignment_of :display_name}
  it { should_not allow_mass_assignment_of :password_digest }
  it { should_not allow_mass_assignment_of :token }

  it { should validate_presence_of :email }
  it { should validate_uniqueness_of :email }
  it { should_not allow_value('not-an-email').for :email }
  it { should allow_value('valid@example.org').for :email }

  it { should validate_presence_of :password }
  it { should_not allow_value('1234567').for :password }
  it { should allow_value('12345678').for :password }

  it { should have_many :reviews }
  it { should have_many :shelves }

  it 'validates confirmation of password' do
    build(:user,
      password: 'doesnotmatch',
      password_confirmation: '!@#$%^&*()'
    ).should_not be_valid
  end

  it 'sets default value of display_name to Anonymous' do
    user.display_name.should eq 'Anonymous'
  end

  it 'sets nil values of display_name to the default' do
    user.display_name = nil
    user.save
    user.display_name.should eq 'Anonymous'
  end

  describe '#authenticate' do
    context 'with valid password' do
      specify { user.authenticate('foopass8').should == user }
    end

    context 'with invalid password' do
      specify { user.authenticate('invalid').should be_false }
    end
  end

  describe '#generate_token' do
    it 'generates a new secure session token' do
      old_token = user.token
      user.generate_token
      user.token.should_not eq old_token
    end

    it 'generates this token on user creation' do
      user.token.should_not be_nil
    end
  end
end
