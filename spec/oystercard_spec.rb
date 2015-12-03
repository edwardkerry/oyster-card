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

  describe '#touch_in' do
    it 'should raise an error if balance is under 1' do
      expect{card.touch_in(:entry_station)}.
      to raise_error "Insufficient funds: #{card.balance}"
    end
  end


  describe '#touch_out' do
    it 'should change @in_use to true when card.touch_out' do
      card.touch_out(:exit_station)
      expect(card).not_to be_in_journey
    end
  end

  describe '#deduct' do
    it 'should check that touch_out changes balance by amount' do
      card.top_up(20)
      expect{card.touch_out(:exit_station)}.
      to change {card.balance}.by -Oystercard::MINIMUM_CHARGE
    end
  end

  describe '#in_journey' do
    it 'should change @in_use to true when card.touch_in' do
      card.top_up(10)
      card.touch_in(:entry_station)
      expect(card).to be_in_journey
    end
  end

  end
