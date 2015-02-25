require 'parapool/error'

class Parapool
  class Job
    attr_accessor :param, :result

    def initialize(param, sync, &block)
      raise Parapool::Error, 'must be called with a block' unless block_given?

      @param = param
      @sync = sync
      @block = block
    end

    def run
      @result = @block.call(param) rescue $!

      @sync.count

      @result
    end
  end
end
