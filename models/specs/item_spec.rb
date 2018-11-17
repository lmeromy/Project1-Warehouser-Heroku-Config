require("minitest/autorun")
require("minitest/rg")
require_relative("../item")
require_relative("../manuf")
# require("pry")

class TestItem < Minitest::Test

  def setup()
    # using 40% margin aka wholesale is 40% off of retail
    @manufacturer1 = Manufacturer.new({'name' => 'Black Diamond', 'sector' => 'Gear'})
    @item1 = Item.new({'product' => 'Climbing Harness', 'category' => 'Climb', 'costprice' => 50, 'sellprice' => 100, 'manuf_id' => @manufacturer1.id, 'quantity' => 100})

  end

  def test_item_has_productname()
    assert_equal("Climbing Harness", @item1.product)
  end

  def test_item_has_category()
    assert_equal("Climb", @item1.category)
  end

  def test_item_costprice_is_integer()
    assert(true, @item1.costprice.integer?)
  end

  def test_update_stock_levels()
    assert_equal("High", @item1.update_stock_levels())
  end

  def test_margin()
    assert_equal(50, @item1.margin())
  end

  def test_net_profit()
    assert_equal(50, @item1.net_profit())
  end

  def test_change_margin_check_sellprice()
    @item1.change_margin(40)
    assert_equal(83, @item1.sellprice)
  end

  def test_change_margin_check_margin()
    @item1.change_margin(40)
    assert_equal(40, @item1.margin)
  end


end
