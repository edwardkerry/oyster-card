require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station1) {double :station}
  let(:exit_station1) {double :station}
  let(:entry_station2) {double :station}
  let(:exit_station2) {double :station}

  it 'starts a journey on touch in' do
    journey.start(:entry_station1)
    expect(journey).not_to be_complete
  end

  it 'ends a journey on touch out' do
    journey.end(:exit_station1)
    expect(journey).to be_complete
  end

  it 'has a minimum fare' do
    journey.start(:entry_station1)
    journey.end(:exit_station2)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'has a penalty fare' do
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'stores the entry station' do
    journey.start(:entry_station1)
    expect(journey.current_journey[0]).to eq :entry_station1
  end

  it 'stores the exit station' do
    journey.start(:entry_station1)
    journey.end(:exit_station1)
    expect(journey.current_journey[1]).to eq :exit_station1
  end

  it 'gives a penalty if not tapped in' do
    journey.end(:exit_station1)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'gives a penalty if not touched out' do
    journey.start(:entry_station1)
    journey.start(:entry_station2)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  describe 'complete journey' do
    it 'should have a history log' do
      journey.start(entry_station1)
      journey.end(exit_station1)
      journey.start(entry_station2)
      journey.end(exit_station2)
      expect(journey.history_log).to eq [[entry_station1, exit_station1],[entry_station2, exit_station2]]
    end
  end

end
