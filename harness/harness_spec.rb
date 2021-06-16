require 'rspec'
require './lib/car'
require './lib/train'
require './lib/train_yard'
require 'pry'
​
RSpec.configure do |config|
  config.default_formatter = 'doc'
end
​
RSpec.describe 'Choo Choo Train Spec Harness 🚂' do
  before :each do
    @mail       = Car.new({type: 'Mail', weight: 5})
    @passengers = Car.new({type: 'Passengers', weight: 1})
    @cattle     = Car.new({type: 'Cattle', weight: 3})
    @dining     = Car.new({type: 'Dining', weight: 4})
​
    @thomas     = Train.new({name: 'Thomas', type: 'Tank'})
    @emily      = Train.new({name: 'Emily', type: 'Tender'})
    @nia        = Train.new({name: 'Nia', type: 'Tank'})
    @gordon     = Train.new({name: 'Gordon', type: 'Express'})
  end
​
  describe 'Iteration 1' do
    it '1. Car Creation' do
      expect(Car).to respond_to(:new).with(1).argument
      expect(@mail).to be_an_instance_of(Car)
    end
​
    it '2. Car attributes' do
      expect(@mail).to respond_to(:type).with(0).argument
      expect(@mail.type).to eq('Mail')
​
      expect(@mail).to respond_to(:weight).with(0).argument
      expect(@mail.weight).to eq(5)
    end
​
    it '3. Train Creation' do
      expect(Train).to respond_to(:new).with(1).argument
      expect(@thomas).to be_an_instance_of(Train)
    end
​
    it '4. Train attributes' do
      expect(@thomas).to respond_to(:name).with(0).argument
      expect(@thomas).to respond_to(:type).with(0).argument
      expect(@thomas).to respond_to(:cargo).with(0).argument
​
      expect(@thomas.name).to eq('Thomas')
      expect(@thomas.type).to eq('Tank')
      expect(@thomas.cargo).to eq({})
    end
​
    it '5. Train can add cars' do
      expect(@thomas).to respond_to(:count_cars).with(1).argument
      expect(@thomas).to respond_to(:add_cars).with(2).argument
​
      expect(@thomas.count_cars(@mail)).to eq(0)
​
      @thomas.add_cars(@mail, 5)
​
      expect(@thomas.count_cars(@mail)).to eq(5)
​
      @thomas.add_cars(@mail, 3)
​
      expect(@thomas.count_cars(@mail)).to eq(8)
​
      expected = {@mail => 8}
​
      expect(@thomas.cargo).to eq(expected)
​
      @thomas.add_cars(@passengers, 2)
​
      expected = {
        @mail => 8,
        @passengers => 2
      }
​
      expect(@thomas.cargo).to eq(expected)
    end
  end
​
  describe 'Iteration 2' do
​
    before :each do
      @brighton = TrainYard.new({location: 'Brighton'})
    end
​
    it '1. Train Yard Creation' do
      expect(TrainYard).to respond_to(:new).with(1).argument
      expect(@brighton).to be_an_instance_of(TrainYard)
    end
​
    it '2. Train Yard Attributes' do
      expect(@brighton).to respond_to(:trains).with(0).argument
      expect(@brighton.trains).to eq([])
    end
​
    it '3. Train Yard Adds Trains' do
      expect(@brighton).to respond_to(:add_train).with(1).argument
​
      @brighton.add_train(@emily)
      @brighton.add_train(@nia)
​
      expect(@brighton.trains).to eq([@emily, @nia])
    end
​
    it '4. Train can calculate its weight' do
      expect(@thomas).to respond_to(:weight).with(0).argument
​
      @thomas.add_cars(@mail, 5)
​
      expect(@thomas.weight).to eq(25)
​
      @thomas.add_cars(@dining, 5)
​
      expect(@thomas.weight).to eq(45)
    end
​
    it '5. Train Yard knows types of trains' do
      @brighton.add_train(@thomas)
      @brighton.add_train(@emily)
      @brighton.add_train(@nia)
      @brighton.add_train(@gordon)
​
      expect(@brighton).to respond_to(:types_of_trains).with(0).argument
      expected = ['Express', 'Tank', 'Tender']
​
      expect(@brighton.types_of_trains).to eq(expected)
    end
​
    it '6. Train yard can give trains containting' do
      @thomas.add_cars(@mail, 5)
      @thomas.add_cars(@passengers, 2)
​
      @emily.add_cars(@mail, 3)
      @emily.add_cars(@dining, 4)
​
      @nia.add_cars(@mail, 1)
​
      @gordon.add_cars(@dining, 5)
      @gordon.add_cars(@cattle, 5)
​
      @brighton.add_train(@thomas)
      @brighton.add_train(@emily)
      @brighton.add_train(@nia)
      @brighton.add_train(@gordon)
​
      expect(@brighton).to respond_to(:trains_containing).with(1).argument
​
      expect(@brighton.trains_containing(@mail)).to eq([@thomas, @emily, @nia])
    end
  end
​
  describe 'Iteration 3' do
​
    before :each do
      @brighton = TrainYard.new({location: 'Brighton'})
​
      @thomas.add_cars(@mail, 5)
​
      @emily.add_cars(@mail, 3)
      @emily.add_cars(@dining, 4)
​
      @nia.add_cars(@mail, 1)
​
      @gordon.add_cars(@dining, 5)
      @gordon.add_cars(@cattle, 5)
​
      @brighton.add_train(@thomas)
      @brighton.add_train(@emily)
      @brighton.add_train(@nia)
      @brighton.add_train(@gordon)
    end
​
    it '1. Train Yard sorts cargo' do
      expect(@brighton).to respond_to(:sorted_cargo_list).with(0).argument
      expect(@brighton.sorted_cargo_list).to eq(['Cattle', 'Dining', 'Mail'])
    end
​
    it '2. Train Yard total inventory' do
      expect(@brighton).to respond_to(:total_inventory).with(0).argument
​
      expected = {
        @mail => 9,
        @dining => 9,
        @cattle => 5
      }
​
      expect(@brighton.total_inventory).to eq(expected)
    end
​
    it '3. Train Yard Overflow Cars' do
      expect(@brighton).to respond_to(:overflow_cars).with(0).argument
      @thomas.add_cars(@mail, 10)
      @gordon.add_cars(@cattle, 20)
​
      expect(@brighton.overflow_cars).to eq([@mail])
    end
  end
​
  describe 'Iteration 4' do
    before :each do
      @brighton = TrainYard.new({location: 'Brighton'})
​
      @thomas.add_cars(@mail, 5)
​
      @emily.add_cars(@mail, 3)
      @emily.add_cars(@dining, 4)
​
      @nia.add_cars(@mail, 1)
​
      @gordon.add_cars(@dining, 5)
      @gordon.add_cars(@cattle, 5)
​
      @brighton.add_train(@thomas)
      @brighton.add_train(@emily)
      @brighton.add_train(@nia)
      @brighton.add_train(@gordon)
    end
​
    it '1. Can unload' do
      expect(@brighton).to respond_to(:unload).with(2).argument
      expect(@brighton.unload(@cattle, 100)).to eq(false)
​
      expect(@brighton.unload(@mail, 7)).to eq(true)
​
      expect(@thomas.count_cars(@mail)).to eq(0)
      expect(@emily.count_cars(@mail)).to eq(1)
    end
  end
end
