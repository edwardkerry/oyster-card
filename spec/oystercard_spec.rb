require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}


  describe 'card balance' do
    it 'should have a balance of 0' do
      expect(card.balance).to eq 0
    end
  end

  describe 'journey history' do
    it 'shout initialize with empty journey hash' do
      expect(card.journey).to be_empty
    end

    #let(:journey){ {entry_station: entry_station, exit_station: exit_station}}
    it 'should store journey in hash' do
      card.top_up(20)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.journey).to include(:entry_station=>:exit_station)#journey
    end

    it 'should initialize with empty history array' do
      expect(card.history).to be_empty
    end
  end

  describe '#top_up' do
    it 'should increase the existing balance by an amount' do
        expect{card.top_up(1)}.to change {card.balance}.by 1
    end

    it 'should enforce a maximum balance on top up' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      expect{card.top_up(1)}.
      to raise_error "Balance limit is #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  describe '#deduct' do

    it 'should check that touch_out changes balance by amount' do
      card.top_up(20)
      expect{card.touch_out(:exit_station)}.
      to change {card.balance}.by -Oystercard::MINIMUM_CHARGE
    end
  end

  describe '#touch_in' do
    it 'should raise an error if balance is under 1' do
      expect{card.touch_in(:entry_station)}.
      to raise_error "Insufficient funds: #{card.balance}"
    end

    it 'should define starting station' do
      card.top_up(20)
      card.touch_in(:entry_station)
      expect(card.starting_station).to eq :entry_station
    end
  end

  describe '#in_journey' do
    it 'should change @in_use to true when card.touch_in' do
      card.top_up(10)
      card.touch_in(:entry_station)
      expect(card).to be_in_journey
    end

  describe '#touch_out' do
    it 'should change @in_use to true when card.touch_out' do
      card.touch_out(:exit_station)
      expect(card).not_to be_in_journey
    end
  end

    it 'should define end station' do
      card.touch_out(:exit_station)
      expect(card.end_station).to eq :exit_station
    end

    it 'should forget the starting station' do
      card.top_up(10)
      card.touch_in(:entry_station)
      card.touch_out(:exit_station)
      expect(card.starting_station).to eq nil
    end
  end
end
