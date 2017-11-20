require_relative "../lib/checkout.rb"

describe Checkout do
  subject(:checkout) { described_class.new(rules) }
  let(:rules) { nil }

  it 'tests are working' do
    expect(1).to eq 1
  end

  describe 'Pricing' do
    def price(goods)
      goods.split(//).each { |item| checkout.scan(item) }
      checkout.total
    end

    it { expect(price('')).to eq 0 }
    it { expect(price("A")).to eq(50) }
    it { expect(price("AB")).to eq(80) }
    it { expect(price("CDBA")).to eq(115) }

    it { expect(price("AA")).to eq(100) }
    it { expect(price("AAA")).to eq(130) }
    it { expect(price("AAAA")).to eq(180) }
    it { expect(price("AAAAA")).to eq(230) }
    it { expect(price("AAAAAA")).to eq(260) }

    it { expect(price("AAAB")).to eq(160) }
    it { expect(price("AAABB")).to eq(175) }
    it { expect(price("AAABBD")).to eq(190) }
    it { expect(price("DABABA")).to eq(190) }
  end

  describe 'Incremental test' do
    it do
      expect(checkout.total).to eq 0

      checkout.scan("A")
      expect(checkout.total).to eq 50

      checkout.scan("B")
      expect(checkout.total).to eq 80

      checkout.scan("A")
      expect(checkout.total).to eq 130

      checkout.scan("A")
      expect(checkout.total).to eq 160

      checkout.scan("B")
      expect(checkout.total).to eq 175
    end
  end
end
