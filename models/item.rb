require_relative('../db/sql_runner')
require_relative('./manuf')
# require('pry')

class Item
  attr_reader(:id, :product, :category)
  attr_accessor(:costprice, :sellprice, :manuf_id, :quantity, :stock_level)

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @product = options['product']
    @category = options['category']
    @costprice = options['costprice'].to_i
    @sellprice = options['sellprice'].to_i
    @manuf_id = options['manuf_id'].to_i
    @quantity = options['quantity'].to_i
    @stock_level = stock_level
  end

  def save()
    sql = "INSERT INTO items (product, category, costprice, sellprice, manuf_id, quantity) VALUES ($1, $2, $3, $4, $5, $6) RETURNING id"
    values = [@product, @category, @costprice, @sellprice, @manuf_id, @quantity]
    results = SqlRunner.run(sql, values)
    @id = results.first()['id'].to_i
  end

  def update()
    sql = "UPDATE items SET (product, category, costprice, sellprice, manuf_id, quantity) = ($1, $2, $3, $4, $5, $6) WHERE id = $7"
    values = [@product, @category, @costprice, @sellprice, @manuf_id, @quantity, @id]
    results = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM items WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

# returns the manufacturer object linked to the given item
  def brand()
    sql = "SELECT * FROM manufacturers WHERE id = $1"
    values = [@manuf_id]
    brand = SqlRunner.run(sql, values)
    return brand.map{|manuf| Manufacturer.new(manuf)}[0]
  end

  def update_stock_levels
    case self.quantity
    when 0...10
      @stock_level = '1 - Reorder Stock!'
    when 10...30
      @stock_level = '2 - Low'
    when 30...60
      @stock_level = '3 - Medium'
    else
      @stock_level = '4 - High'
    end
    self.update()
    return @stock_level[4..-1]
  end

  # this is the percentage markup (aka % increase in retail v wholesale price)
  def margin()
    # binding.pry
    calc = ((1.0 - (@costprice.to_f / @sellprice.to_f)) * 100.0).round().to_i
    return calc
  end


  def change_margin(delta)
     # binding.pry
    calc = delta.to_f/100.0
    new_sellprice = @costprice.to_f / (1.0-calc)
    self.sellprice = new_sellprice.to_i
    self.update()
  end

  def net_profit()
    net = self.sellprice - self.costprice
    return net
  end

  def self.find(id)
    sql = "SELECT * FROM items WHERE id = $1"
    values = [id]
    item_object = SqlRunner.run(sql, values)
    result = Item.new(item_object.first)
    return result
  end

  def self.all()
    sql = "SELECT * FROM items"
    items = SqlRunner.run(sql)
    result = items.map { |item_object| Item.new(item_object)}
    return result
  end

  def self.all_sort_category()
    sql = "SELECT * FROM items ORDER BY category"
    items = SqlRunner.run(sql)
    result = items.map { |item_object| Item.new(item_object)}
    return result
  end

  def self.all_winter()
    items_winter = []
    items = Item.all()
    for item in items
      if item.category == "Ski" || item.category == 'General-Cold'
        items_winter << item
      end
    end
    return items_winter
  end

  def self.all_summer()
    items_summer = []
    items = Item.all()
    for item in items
      if item.category == "Climb" || item.category == 'General-Warm'
        items_summer << item
      end
    end
    return items_summer
  end

  def self.sort_stocklevels()
    sql = "SELECT * FROM items ORDER BY stock_level"
    items = SqlRunner.run(sql)
    result = items.map { |item_object| Item.new(item_object)}
    result.each do |item|
      item.update_stock_levels
    end
    sorted = result.sort_by {|x| x.stock_level}
    return sorted
  end

  def self.delete_all()
    sql = "DELETE FROM items"
    result = SqlRunner.run(sql)
  end


end
