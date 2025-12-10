# Design Patterns Refactoring – Ruby

This project demonstrates how to refactor poorly structured Ruby code using three important Design Patterns:

- **Bridge Pattern** – for notifications
- **Singleton Pattern** – for application configuration
- **Strategy Pattern** – for shipping calculations

Each section explains the problem, the goal, and the refactored clean solution.

---

## 🚀 1. Bridge Pattern – Notification System

### ❌ Problem

The original `Notification` class used multiple `if/else` statements to handle Email, SMS, and Push messages.  
This caused tight coupling, made the code difficult to extend, and violated the Open/Closed Principle.

### 🎯 Goal

- Separate the **abstraction** (Notification) from the **implementation** (sending methods).
- Add new notification types or delivery methods without modifying existing code.
- Remove all conditionals.

### ✅ Solution – Bridge Pattern

```ruby
class NotificationType
  def send(message)
    raise NotImplementedError
  end
end

class Email < NotificationType
  def send(message)
    puts "Sending Email: #{message}"
  end
end

class SMS < NotificationType
  def send(message)
    puts "Sending SMS: #{message}"
  end
end

class Push < NotificationType
  def send(message)
    puts "Sending Push: #{message}"
  end
end

class Notification
  def initialize(type)
    @type = type
  end

  def send(message)
    @type.send(message)
  end
end

class AlertNotification < Notification
  def send(message)
    super("ALERT: #{message}")
  end
end

class ReportNotification < Notification
  def send(message)
    super("REPORT: #{message}")
  end
end
```

# Example

email = Email.new
notif = AlertNotification.new(email)
notif.send("Hello World")

---

## 🔒 2. Singleton Pattern – AppConfig

### ❌ Problem

The original AppConfig created a new instance every time, which breaks consistency.

### 🎯 Goal

- Only one instance exists.
- Prevent creating new objects, cloning, or duplicating.
- Access settings globally.

### ✅ Solution – Singleton Pattern

```ruby
require 'singleton'

class AppConfig
  include Singleton

  def initialize
    @settings = { env: 'production' }
  end

  def [](key)
    @settings[key]
  end
end

c1 = AppConfig.instance
c2 = AppConfig.instance

puts c1.equal?(c2)  # true
puts c1[:env]
```

---

## 📦 3. Strategy Pattern – Shipping Calculator

### ❌ Problem

The original calculator used conditionals to select the shipping method.

### 🎯 Goal

- Separate each shipping rule into its own strategy.
- Remove all if/else logic.
- Allow injecting the shipping company dynamically.

### ✅ Solution – Strategy Pattern

```ruby
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
    raise NotImplementedError
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

# Example
calc = ShippingCalculator.new(Aramex.new)
puts calc.calculate(OpenStruct.new(weight: 5))
```
