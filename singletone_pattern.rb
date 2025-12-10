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
puts c1.equal?(c2)
puts c1[:env]

# or
# class AppConfig
#    @instance_mutex = Mutex.new
#    private_class_method :new
#    def initialize
#      @settings = { env: "production" }
#    end

#    def clone
#     raise "Can't clone this config"
#    end

#    def dup
#      raise "Can't duplicate this config"
#    end

#    def self.instance
#      return @instance if @instance
#      @instance_mutex.synchronize do
#        @instance ||= new
#      end
#      @instance
#    end

#    def [](key)
#      @settings[key]
#    end
#  end

#  c1 = AppConfig.instance
#  c2 = AppConfig.instance
#  puts c1.object_id == c2.object_id
#  puts c1[:env]
