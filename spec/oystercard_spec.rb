require 'oystercard'

describe Oystercard do

  subject(:card) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let (:journey) {double :journey, PENALTY_FARE: nil, MINIMUM_FARE: nil}

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
        context 'when not tapped out' do
          it 'should charge a penalty fare' do
            card.top_up(20)
            card.touch_in(:entry_station)
            expect{card.touch_in(:exit_station)}.to change {card.balance}.by -Journey::PENALTY_FARE
          end
        end
      end
    end

    describe '#touch_out' do
      context 'when touched in' do
        it 'should change @in_use to false' do
          card.touch_out(:exit_station)
          expect(card.in_use).to be false
        end
        it 'should deduct the minimum fare' do
          card.top_up(20)
          card.touch_in(:entry_station)
          expect{card.touch_out(:exit_station)}.
          to change {card.balance}.by -Journey::MINIMUM_FARE
        end
      end
      context 'when not touched in' do
        it 'should charge a pentalty fare' do
          card.top_up(20)
          expect{card.touch_out(:exit_station)}.
          to change {card.balance}.by -(Journey::PENALTY_FARE + Journey::MINIMUM_FARE)
        end
      end
    end
  end
end
