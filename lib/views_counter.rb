require 'redis'

class ViewsCounter
   @@redis = Redis.new(:db => 1)
   def self.incr(id)
     @@redis.incr id.to_s
   end
end
