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

email = Email.new
notif = AlertNotification.new(email)
notif.send('Hello Wrold')
