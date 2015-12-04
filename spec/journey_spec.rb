require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station1) {double :station, zone: 1}
  let(:exit_station1) {double :station, zone: 1}
  let(:entry_station2) {double :station, zone: 5}
  let(:exit_station2) {double :station, zone: 5}

  it 'starts a journey on touch in' do
    journey.start(entry_station1)
    expect(journey.entry_station).to eq entry_station1
  end

  it 'ends a journey on touch out' do
    journey.end_journey(exit_station1)
    expect(journey.exit_station).to eq exit_station1
  end

  it 'has a minimum fare' do
    journey.start(entry_station2)
    journey.end_journey(exit_station2)
    expect(journey.fare).to eq Journey::MINIMUM_FARE
  end

  it 'gives a penalty if not tapped in' do
    journey.end_journey(exit_station1)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'gives a penalty if not touched out' do
    journey.start(entry_station1)
    journey.start(entry_station2)
    expect(journey.fare).to eq Journey::PENALTY_FARE
  end

  it 'should charge more for multi-zone journey' do
    journey.start(entry_station1)
    journey.end_journey(exit_station2)
    expect(journey.fare).to eq 5
  end

end
