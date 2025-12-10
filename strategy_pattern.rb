require 'ostruct'

class ShippingCalculator
  attr_accessor :shipping_company

  def initialize(shipping_company)
    @shipping_company = shipping_company
  end

  def calculate(order)
    @shipping_company.calculate(order)
  end
end

class ShippingCompany
  def calculate(order)
    raise NoImplementedError
  end
end

class Fedex < ShippingCompany
  def calculate(order)
    order.weight * 10 + 15
  end
end

class Aramex < ShippingCompany
  def calculate(order)
    order.weight * 8 + 10
  end
end

class DHL < ShippingCompany
  def calculate(order)
    order.weight * 12 + 20
  end
end

calc = ShippingCalculator.new(Aramex.new)
puts calc.calculate(OpenStruct.new(weight: 5))
