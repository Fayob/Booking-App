require 'rails_helper'

describe Coach, type: :model do
  @user = User.create(id: 1, name: 'John Doe', username: 'doe2', password: 'password')

  subject do
    Coach.create(user: @user, name: 'Kelly', description: 'A Software Developer')
  end

  before { subject.save }

  describe 'validation' do
    it 'tests the presence of user parameter' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'should validate name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'should validate description' do
      subject.description = nil
      expect(subject).to_not be_valid
    end
  end
end
