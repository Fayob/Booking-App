require 'rails_helper'

describe Reseve, type: :model do
  @user = User.create(id: 1, name: 'John Doe', username: 'doe1', password: 'password')
  @coach = Coach.create(id: 1, name: "Kelly", description: "A Software Developer", city: "Berlin")
  subject do
    Reserve.create(user: @user, coach: @coach)
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