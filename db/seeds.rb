require_relative('../models/item')
require_relative('../models/manuf')
# require('pry')


Item.delete_all()
Manufacturer.delete_all()


manufacturer1 = Manufacturer.new({'name' => 'Black Diamond', 'sector' => 'Gear'})
manufacturer2 = Manufacturer.new({'name' => 'Patagonia', 'sector' => 'Technical Clothing'})
manufacturer3 = Manufacturer.new({'name' => 'Melanzana', 'sector' => 'Clothing'})
manufacturer4 = Manufacturer.new({'name' => 'Petzl', 'sector' => 'Gear'})

manufacturer1.save()
manufacturer2.save()
manufacturer3.save()
manufacturer4.save()


item1 = Item.new({'product' => 'Climbing Harness', 'category' => 'Climb', 'costprice' => 50, 'sellprice' => 100, 'manuf_id' => manufacturer1.id, 'quantity' => 30})

item2 = Item.new({'product' => 'Rope', 'category' => 'Climb', 'costprice' => 84, 'sellprice' => 140, 'manuf_id' => manufacturer1.id, 'quantity' => 20})

item3 = Item.new({'product' => 'Softshell jacket', 'category' => 'General-Cold', 'costprice' => 72, 'sellprice' => 120, 'manuf_id' => manufacturer2.id, 'quantity' => 50})

item4 = Item.new({'product' => 'Insulated down jacket', 'category' => 'General-Cold', 'costprice' => 108, 'sellprice' => 180, 'manuf_id' => manufacturer2.id, 'quantity' => 50})
item5 = Item.new({'product' => 'SheSkis 160', 'category' => 'Ski', 'costprice' => 400, 'sellprice' => 800, 'manuf_id' => manufacturer1.id, 'quantity' => 50})

item6 = Item.new({'product' => 'Climbing Helmet', 'category' => 'Climb', 'costprice' => 20, 'sellprice' => 55, 'manuf_id' => manufacturer4.id, 'quantity' => 100})

item7 = Item.new({'product' => 'Ski Goggles', 'category' => 'Ski', 'costprice' => 20, 'sellprice' => 40, 'manuf_id' => manufacturer1.id, 'quantity' => 30})
# binding.pry
# nil
item1.save()
item2.save()
item3.save()
item4.save()
item5.save()
item6.save()
item7.save()

item1.update_stock_levels


Item.sort_stocklevels()

# stock4.delete()
# binding.pry
# nil
