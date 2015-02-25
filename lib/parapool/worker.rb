require 'thread'

class Parapool
  class Worker
    def initialize(queue)
      raise TypeError, "wrong argument type #{queue.class} (expected Queue)" unless queue.is_a?(Queue)

      @queue = queue
    end

    def run
      @thread = Thread.new do
        while job = @queue.pop do
          job.run
        end
      end

      self
    end

    def join
      @thread.join
    end
  end
end
