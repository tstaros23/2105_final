require 'rspec'
require './lib/train'
require './lib/car'

RSpec.describe 'Train' do
  it "exists" do
    train1 = Train.new({name: 'Thomas', type: 'Tank'})
  end

  it "has attributes" do
    train1 = Train.new({name: 'Thomas', type: 'Tank'})

    expect(train1.name).to eq('Thomas')
    expect(train1.type).to eq('Tank')
  end
  it "can count cars" do
    car1 = Car.new({type: 'Mail', weight: 5})
    car2 = Car.new({type: 'Passengers', weight: 1})
    train1 = Train.new({name: 'Thomas', type: 'Tank'})

    expect(train1.cargo).to eq({})
    expect(train1.count_cars(car1)).to eq(0)
    train1.add_cars(car1, 2)
    expect(train1.cargo).to eq(car1 => 2)
    expect(train1.count_cars(car1)).to eq(2)
    train1.add_cars(car1, 3)
    # expect(train1.cargo).to eq(car1 => 5)
    expect(train1.count_cars(car1)).to eq(5)
  end

end
