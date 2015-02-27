require 'spec_helper'

describe Parapool do
  it 'has a version number' do
    expect(Parapool::VERSION).not_to be nil
  end

  context 'when create instance without pool size' do
    let(:pool) { Parapool.new }

    it 'must be able to get pool size' do
      expect(pool.pool_size).to eq(4)
    end
  end

  context 'when create instance with pool size' do
    let(:pool) { Parapool.new(10) }

    it 'must be able to get pool size' do
      expect(pool.pool_size).to eq(10)
    end
  end

  context 'when run tasks in Parapool' do
    let(:pool) { Parapool.new }
    let(:params) { (1..10).to_a }

    before do
      @results = pool.map(params) { |num| num * 2 }
    end

    it 'must be able to get results' do
      expect(@results).to eq(params.map { |num| num * 2 })
    end

  end
end
