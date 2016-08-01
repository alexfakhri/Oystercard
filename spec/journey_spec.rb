require 'journey'

describe Journey do

  let(:station) { double :station, Zone:1 }

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'retunrs itself when exiting a journey' do
    expect(subject.exit(station)).to eq(subject)
  end

  context 'give an exntry station' do

    subject {described_class.new(entry_station: station)}

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do

      let(:other_station)  { double :other_station }

      before do
        subject.exit(other_station)
      end

      it 'calculates a fare' do
        expect(subject.fare).to eq 1
      end

      it 'knows when a journey is complete' do
        expect(subject).to be_complete
      end

    end


  end


end
