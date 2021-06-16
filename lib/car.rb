class Car
  attr_reader :weight, :type
  def initialize(car_info)
    @weight = car_info[:weight]
    @type = car_info[:type]
  end
end
