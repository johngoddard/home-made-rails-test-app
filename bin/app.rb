require_relative '../lib/router'
require 'rack'
require_relative '../lib/db_connection'
require_relative '../app/models/user'
require_relative '../app/models/cat'
require_relative '../app/models/cat_rental_request'
require_relative '../app/controllers/cats_controller'
require_relative '../app/controllers/users_controller'
require_relative '../app/controllers/sessions_controller'
require_relative '../app/controllers/cat_rental_requests_controller'
require 'rack'
require_relative '../config/constants'

DBConnection.reset

c = Constants.new

h = User.new(username: "John", password: "password", session_token: SecureRandom.urlsafe_base64(16))
h1 = User.new(username: "Andrea", password: "password", session_token: SecureRandom.urlsafe_base64(16))
h.save
h1.save

c1 = Cat.new(name: "Cato", owner_id: 1)
c2 = Cat.new(name: "Moto", owner_id: 1)
c1.save
c2.save

r1 = CatRentalRequest.new(cat_id: 1, user_id: 2, start_date: '2016-09-01 10:00:00', end_date: '2016-09-21 10:00:00')
r1.save

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

Rack::Server.start(
 app: app,
 Port: c.port
)
