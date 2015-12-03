require 'journey'

describe Journey do

  subject(:journey) {described_class.new}
  let(:entry_station1) {double :station}
  let(:exit_station1) {double :station}
  let(:entry_station2) {double :station}
  let(:exit_station2) {double :station}

  describe 'complete journey' do
    it 'should have a history log' do
      journey.start(entry_station1)
      journey.end(exit_station1)
      journey.start(entry_station2)
      journey.end(exit_station2)
      expect(journey.history_log[2]).to eq [entry_station2, exit_station2]
    end
  end

end
