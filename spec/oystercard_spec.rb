require 'oystercard'

describe Oystercard do

subject(:card) {described_class.new}

  it 'should have a balance of 0' do
    expect(subject.balance).to eq 0
  end

  describe '#top_up' do
    it 'should increase the balance by 10 after topping up with 10' do
        card.top_up(10)
        expect(card.balance).to eq 10
    end
  end


end