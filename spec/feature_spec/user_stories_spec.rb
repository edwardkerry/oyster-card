describe 'User Stories' do

  # User Story 1
  # In order to use public transport
  # As a customer
  # I want money on my card

  it 'has a balance' do
    card = Oystercard.new
    expect(card.balance).to eq 0
  end

  # User Story 2
  # In order to keep using public transport
  # As a customer
  # I want to add money to my card

  it 'top up' do
    card = Oystercard.new
    card.top_up(20)
    expect(card.balance).to eq 20
  end

  # User Story 3
  # In order to protect my money
  # As a customer
  # I don't want to put too much money on my card

  it 'maximum balance' do
    card = Oystercard.new
    card.top_up(Oystercard::MAXIMUM_BALANCE)
    expect{card.top_up(1)}.to raise_error "Balance limit is #{Oystercard::MAXIMUM_BALANCE}"
  end

  # User Story 4
  # In order to pay for my journey
  # As a customer
  # I need my fare deducted from my card
  it 'deduct fare' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    expect{card.touch_out(:Angel)}.to change{card.balance}.by -Oystercard::MINIMUM_CHARGE
  end


  # User Story 5
  # In order to get through the barriers
  # As a customer
  # I need to touch in and out
  it 'touch in' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    expect(card.in_use).to eq true
  end

  it 'touch out' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    card.touch_out(:Waterloo)
    expect(card.in_use).to eq false
  end

  # User Story 6
  # In order to pay for my journey
  # As a customer
  # I need to have the minimum amount for a single journey
  it 'enforce a minimum charge' do
    card = Oystercard.new
    expect{card.touch_in(:Waterloo)}.to raise_error "Insufficient funds: #{card.balance}"
  end

  #   User Story 7
  # In order to pay for my journey
  # As a customer
  # I need to pay for my journey when it's complete
  it 'deduct  fare on completing a journey' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    expect{card.touch_out(:Angel)}.to change{card.balance}.by -Oystercard::MINIMUM_CHARGE
  end

  # User Story 8
  # In order to pay for my journey
  # As a customer
  # I need to know where I've travelled from
  it 'log entry station' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    expect(card.journey.current_journey[0]).to eq :Waterloo
  end

  # User Story 9
  # In order to know where I have been
  # As a customer
  # I want to see to all my previous trips

  it 'stores a history log' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    card.touch_out(:Kings_Cross)
    card.touch_in(:Angel)
    card.touch_out(:Waterloo)
    expect(card.journey.history_log).to eq([[:Waterloo, :Kings_Cross], [:Angel, :Waterloo]])
  end

  #User Story 10
  # In order to be charged correctly
  # As a customer
  # I need a penalty charge deducted if I fail to touch in or out

  it 'charges a penalty when not touched out' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    expect{card.touch_in(:Angel)}.to change{card.balance}.by -Oystercard::PENALTY_FARE
  end

  it 'charges a penalty when not touched in' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_out(:Waterloo)
    expect{card.touch_out(:Angel)}.to change{card.balance}.by -(Oystercard::PENALTY_FARE + Oystercard::MINIMUM_CHARGE)
  end

  # User Story 11
  # In order to be charged the correct amount
  # As a customer
  # I need to have the correct fare calculated


end
