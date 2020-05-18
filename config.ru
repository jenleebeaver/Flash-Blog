require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

#this gives us access to put/patch and delete in our controllers
use Rack::MethodOverride


use BlogpostsController
use TitlesController
use UsersController
use SessionsController
run ApplicationController #where we mount our controllers




