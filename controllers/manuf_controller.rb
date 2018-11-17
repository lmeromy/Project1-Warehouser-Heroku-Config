require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?

require_relative('../models/item')
require_relative('../models/manuf')
# also_reload( '/models/*' )


# index route for All manufacturers
get '/manuf' do
  @brands = Manufacturer.all()
  erb(:"manuf/index")
end

# new route for manufacturers
get '/manuf/new' do
  @manufacturers = Manufacturer.all()
  erb(:"manuf/new")
end

# create route for manufacturers
post '/manuf' do
  brand = Manufacturer.new(params)
  brand.save()
  redirect to('/manuf')
end

# edit route
get '/manuf/:id/edit' do
  @brand_object = Manufacturer.find(params['id'].to_i)
  @all_brands = Manufacturer.all()
  erb(:"manuf/edit")
end

# update route
post '/manuf/:id' do
  brand = Manufacturer.new(params)
  brand.update()
  redirect to('/manuf')
end

# delete route
post '/manuf/:id/delete' do
  brand = Manufacturer.find(params['id'].to_i)
  brand.delete()
  redirect to('/manuf')
end
