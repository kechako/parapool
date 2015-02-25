require 'monitor'

class Parapool
  class Synchronizer
    include MonitorMixin

    def initialize(count)
      super()

      @count = count

      @completed = new_cond
    end

    def count
      synchronize do
        @count -= 1

        @completed.broadcast
      end

      self
    end

    def wait
      synchronize do
        @completed.wait_until { @count.zero? }
      end

      self
    end
  end
end
