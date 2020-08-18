RSpec.describe Devise::Async do
  it 'yields self when setup is called' do
    described_class.setup { |config| expect(config).to eq(Devise::Async) }
  end

  it 'stores enabled config' do
    initial_enabled = described_class.enabled

    described_class.enabled = false
    expect(described_class.enabled).to eq(false)
    described_class.enabled = initial_enabled
  end

  it 'stores queue config' do
    initial_queue = described_class.queue

    described_class.queue = :critical
    expect(described_class.queue).to eq(:critical)
    described_class.queue = initial_queue
  end
end
