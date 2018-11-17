require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative('../models/item')
require_relative('../models/manuf')
# also_reload( '/models/*' )


# index route for All items
get '/items' do
  @items = Item.all()
  erb(:"items/index")
end


# new route for items
get '/items/new' do
  @items = Item.all()
  @manufacturers = Manufacturer.all()
  erb(:"items/new")
end

# create route for items
post '/items' do
  item = Item.new(params)
  item.save()
  redirect to('/items')
end

# route to sort all items by stock level in the index
post '/items/sort' do
  @items = Item.sort_stocklevels()
  erb(:"items/index")
end

# edit route
get '/items/:id/edit' do
  @item = Item.find(params['id'].to_i)
  @all_items = Item.all()
  erb(:"items/edit")
end

# update route
post '/items/:id' do
  item = Item.new(params)
  item.update()
  redirect to('/items')
end

# delete route
post '/items/:id/delete' do
  item = Item.find(params['id'].to_i)
  item.delete()
  redirect to('/items')
end
