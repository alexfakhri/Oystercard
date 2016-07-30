require 'oystercard'

describe Oystercard do

  let (:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }


  # In order to use public transport As a customer I want money on my card
  it 'has a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it 'is not initially in journey' do
    expect(subject).not_to be_in_journey
  end

  describe '#top_up' do

    # In order to keep using public transport As a customer I want to add money to my card
    it 'can top up the balance' do
      expect { subject.top_up 1 }.to change{ subject.balance }.by 1
    end

    # In order to protect my money from theft or loss As a customer I want a maximum limit (of £90) on my card
    it 'raises an error if the maximum balance in exceeded' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up 1 }.to raise_error "Maximum balance of #{maximum_balance} exceeded"
    end

  end

  describe '#deduct' do

    # In order to pay for my journey As a customer I need my fare deducted from my card
    it "deducts an amount from the balance" do
      subject.top_up(20)
      expect{ subject.deduct 3 }.to change{ subject.balance }.by -3
    end

  end

  describe 'customer journey' do

    before do
      subject.top_up(Oystercard::MAXIMUM_BALANCE)
      subject.touch_in(station)
    end

    # In order to get through the barriers. As a customer I need to touch in and out.
    it 'can touch in' do
      expect(subject).to be_in_journey
    end

    it 'can touch out' do
      subject.touch_out(station)
      expect(subject.exit_station).to_not be nil
    end

    # In order to pay for my journey As a customer I need to know where I've travelled from
    it 'stores the entry station' do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end

    # In order to know where I have been As a customer I want to see to all my previous trips
    it 'stores the exit station' do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.exit_station).to eq exit_station
    end

  end

  describe 'minmum balance' do

    # In order to pay for my journey As a customer I need to have the minimum amount (£1) for a single journey.
    it 'will not touch in if balance is below minumum balance' do
      expect{ subject.touch_in(station) }.to raise_error "Insufficient balance to touch in"
    end

    it 'will be charged the minimum amount on touch out' do
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change{ subject.balance }.by (-Oystercard::MINIMUM_CHARGE)
    end

  end

end
