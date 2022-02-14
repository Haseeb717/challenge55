class Checkout
  attr_reader :total

  def initialize(rules)
    @rules = rules
    @total = 0
    @items = Hash.new
    @prices = Hash.new
  end

  def scan(item)
    rule = @rules.find{|i| i[:item] == item}
    spu_check = check_spu(item) if rule[:spu]

    if spu_check
      current_item_price = @prices[item].to_i
      count = (@items[item]+1)/rule[:spu]
      sum = count*rule[:spu_price]
      @total = @total - current_item_price
      @total = @total + sum
      @prices[item] = sum
    else
      @total = @total + rule[:price]
      @prices[item] = @prices[item].to_i + rule[:price]
    end
    @items[item] = @items[item].to_i + 1
  end

  private

  def check_spu(item)
    count = @items[item].to_i+1
    spu = @rules.find{|i| i[:item] == item}[:spu]
    return true if count%spu == 0

    return false
  end
end
