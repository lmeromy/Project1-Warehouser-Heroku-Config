require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative('../models/item')
require_relative('../models/manuf')
# also_reload( '/models/*' )


# tools markup route
get '/tools/markup' do
  @items = Item.all_sort_category()
  @manufacturers = Manufacturer.all()
  erb(:"tools/markup")
end

# tools markup EDIT route
get '/tools/:id/edit' do
  @item = Item.find(params['id'].to_i)
  @all_items = Item.all()
  erb(:"tools/edit")
end

# tools optimize WINTER markup route
get '/tools/optimize_winter' do
  @items = Item.all_winter()
  @manufacturers = Manufacturer.all()
  erb(:"tools/optimize_winter")
end

# update margin for winter markup
post '/tools/optimize_winter' do

  margin_update = params['margin'].to_i
  @items_winter = Item.all_winter()

  for item in @items_winter
    item.change_margin(margin_update)
    item.update()
  end
  redirect to('/tools/optimize_winter')
end

# tools optimize SUMMER markup route
get '/tools/optimize_summer' do
  @items = Item.all_summer()
  @manufacturers = Manufacturer.all()
  erb(:"tools/optimize_summer")
end

# update margin for summer markup
post '/tools/optimize_summer' do

  margin_update = params['margin'].to_i
  @items_summer = Item.all_summer()

  for item in @items_summer
    item.change_margin(margin_update)
    item.update()
  end
  redirect to('/tools/optimize_summer')
end


# update margin reset ALL to 50%
post '/tools/reset' do

  # margin_update = params['margin'].to_i
  @items = Item.all()

  for item in @items
    item.change_margin(50)
    item.update()
  end
  redirect to('/tools/markup')
end

# update markup route (for individual items)
post '/tools/:id' do
  item = Item.new(params)
  item.update()
  redirect to('/tools/markup')
end
