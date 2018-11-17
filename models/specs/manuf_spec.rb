require("minitest/autorun")
require("minitest/rg")
require_relative("../item")
require_relative("../manuf")
# require_relative('../db/sql_runner')
# require("pry")

class TestManufacturer < Minitest::Test

  def setup()
    @manufacturer1 = Manufacturer.new({'name' => 'Black Diamond', 'sector' => 'Gear'})
    @item1 = Item.new({'product' => 'Climbing Harness', 'category' => 'Climb', 'costprice' => 50, 'sellprice' => 100, 'manuf_id' => @manufacturer1.id, 'quantity' => 100})

  end

  def test_manuf_has_name()
    assert_equal("Black Diamond", @manufacturer1.name)
  end

  def test_manuf_has_sector()
    assert_equal("Gear", @manufacturer1.sector)
  end

# not working, but it works in pry and with Sinatra! Is this a DB/sql/ruby communication issue?
  def test_products()
    assert_equal(1, @manufacturer1.products.length())
  end


end
