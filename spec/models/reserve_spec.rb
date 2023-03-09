require 'rails_helper'

describe Reserve, type: :model do
  @user = User.create(name: 'John Doe', username: 'doe1', password: 'password')
  @coach = Coach.create(user_id: @user.id, name: 'Kelly', description: 'A Software Developer')
  subject do
    Reserve.create(user: @user, coach: @coach, city: 'Berlin', date: '2023-03-09')
  end

  before { subject.save }

  describe 'validation' do
    it 'tests the presence of user parameter' do
      subject.user = nil
      expect(subject).to_not be_valid
    end

    it 'should validate coach presence' do
      subject.coach = nil
      expect(subject).to_not be_valid
    end
  end
end
