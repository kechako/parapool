require 'parapool/error'
require 'parapool/job'
require 'parapool/synchronizer'
require 'parapool/version'
require 'parapool/worker'
require 'thread'

class Parapool
  attr_reader :pool_size

  def initialize(pool_size = 4)
    raise ArgumentError, 'Pool size must be greater than or equal to 1.' if pool_size < 1

    @pool_size = pool_size
    @queue = Queue.new
    @workers = []

    create_worker
  end

  def map(params, &block)
    raise TypeError, "wrong argument type #{params.class} (expected Enumerable)" unless params.is_a?(Enumerable)
    raise Parapool::Error, 'must be called with a block' unless block_given?

    return if params.empty?

    sync = Synchronizer.new(params.size)

    jobs = []
    params.each do |param|
      job = Job.new(param, sync, &block)
      push(job)
      jobs << job
    end

    sync.wait

    jobs.map { |job| job.result }
  end

  def release
    @workers.size.times.each do
      @queue.push(nil)
    end
    @workers.each do |worker|
      worker.join
    end
  end

private

  def create_worker
    @pool_size.times do
      worker = Worker.new(@queue)
      worker.run
      @workers << worker
    end
  end

  def push(job)
    raise TypeError, "wrong argument type #{job.class} (expected Parapool::Job)" unless job.is_a?(Job)

    @queue.push(job)

    self
  end
end
