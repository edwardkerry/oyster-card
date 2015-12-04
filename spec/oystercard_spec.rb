require 'oystercard'

describe Oystercard do

  let (:journey) {double :journey, PENALTY_FARE: 6, MINIMUM_FARE: 1, start: nil, end_journey: nil, fare: 1, clear: nil}
  let(:journey_klass) { double :journey_klass, new: journey }
  
  subject(:card) {described_class.new(journey_klass)}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  context 'when the card is out of money' do
    describe 'card balance' do
      it 'it should have a balance of 0' do
        expect(card.balance).to eq 0
      end
    end
    describe '#touch_in' do
      it 'it should raise an error if balance is under 1' do
        @in_use = false
        expect{card.touch_in(:entry_station)}.
        to raise_error "Insufficient funds: #{card.balance}"
      end
    end
    it 'it should not allow a top-up over maximum limit' do
      card.top_up(Oystercard::MAXIMUM_BALANCE)
      expect{card.top_up(1)}.
      to raise_error "Balance limit is #{Oystercard::MAXIMUM_BALANCE}"
    end
  end

  context 'when the card is in credit' do
  before(:each){card.top_up(20)}
    describe '#top_up' do
      it 'should increase card balance by given amount' do
          expect{card.top_up(1)}.to change {card.balance}.by 1
      end
    end

    context 'when starting a journey' do
      describe '#touch_in' do
        it 'should change @in_use to true' do
          card.top_up(10)
          card.touch_in(:entry_station)
          expect(card.in_use).to be true
        end
      end
    end

    describe '#touch_out' do
      context 'when touched in' do
        it 'should change @in_use to false' do
          card.touch_out(:exit_station)
          expect(card.in_use).to be false
        end
      end
    end
  end
end
