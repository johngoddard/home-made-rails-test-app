require_relative '../lib/rails_lite/router'
require 'rack'
require_relative '../lib/active_record_lite/db_connection'
require_relative '../app/models/user'
require_relative '../app/models/cat'
require_relative '../app/models/cat_rental_request'
require_relative '../app/controllers/cats_controller'
require_relative '../app/controllers/users_controller'
require_relative '../app/controllers/sessions_controller'
require_relative '../app/controllers/cat_rental_requests_controller'
require 'rack'
require_relative '../config/constants'
require_relative '../lib/middleware/show_exceptions'
require_relative '../lib/middleware/static'
require_relative '../db/seeder'

DBConnection.reset

constants = Constants.new
seed_machine = Seeder.new
seed_machine.seed

router = Router.new
router.draw do
  get Regexp.new("^/cats$"), CatsController, :index
  get Regexp.new("^/cats/new$"), CatsController, :new
  post Regexp.new("^/cats$"), CatsController, :create

  post Regexp.new("^/users$"), UsersController, :create
  get Regexp.new("^/users/new$"), UsersController, :new
  get Regexp.new("^/users/(?<id>\\d+)$"), UsersController, :show

  post Regexp.new("^/session$"), SessionsController, :create
  get Regexp.new("^/session/new$"), SessionsController, :new
  post Regexp.new("^/session/logout$"), SessionsController, :destroy

  get Regexp.new("^/cat_rental_requests$"), CatRentalRequestsController, :index
  get Regexp.new("^/cat_rental_requests/new$"), CatRentalRequestsController, :new
  post Regexp.new("^/cat_rental_requests$"), CatRentalRequestsController, :create
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)

  res.finish
end

app = Rack::Builder.new do
  use Static
  use ShowExceptions
  run app
end.to_app

Rack::Server.start(
 app: app,
 Port: constants.port
)
