require 'rails_helper'

describe User, type: :model do
  subject do
    User.create(name: 'John Doe', username: 'doe1', password: 'password')
  end

  before { subject.save }

  describe 'validation' do
    it 'tests the presence of name parameter' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should have a valid name' do
      expect(subject.name).to eql('John Doe')
    end

    it 'should validate username' do
      subject.username = nil
      expect(subject).to_not be_valid
    end

    it 'should validate password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'should create user successfully if all fields is supplied' do
      expect(subject).to be_valid
    end
  end
end
