require 'journey'

describe Journey do

  let(:station) { double :station, Zone:1 }

  it 'knows if a journey is not complete' do
    expect(subject).not_to be_complete
  end

  it 'has a penalty dare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end


end
