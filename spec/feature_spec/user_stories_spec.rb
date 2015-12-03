describe 'User Stories' do

  #Step 12
  #In order to know where I have been
  #As a customer
  #I want to see all my previous trips

  it 'stores a history log' do
    card = Oystercard.new
    card.top_up(20)
    card.touch_in(:Waterloo)
    card.touch_out(:Kings_Cross)
    card.touch_in(:Angel)
    card.touch_out(:Waterloo)
    expect(card.journey.history_log).to eq(1 =>[:Waterloo, :Kings_Cross], 2=> [:Angel, :Waterloo])
  end



end
