class Train
  attr_reader :name, :type, :cargo
  def initialize(train_info)
    @name = train_info[:name]
    @type = train_info[:type]
    @cargo = Hash.new(0)
  end

  def count_cars(car)
    sum = 0
    @cargo.each_value do |car|
      sum += car
    end
    sum
  end
  require "pry"; binding.pry

  def add_cars(car,amount)
    @cargo[car] = amount
  end
end
