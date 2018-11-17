require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative('models/item')
require_relative('models/manuf')
# also_reload( '/models/*' )
require_relative('controllers/item_controller')
require_relative('controllers/manuf_controller')
require_relative('controllers/tools_controller')


# this is the homepage! will have nav!
get '/' do
  erb(:index)
end
