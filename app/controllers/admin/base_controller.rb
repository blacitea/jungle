class Admin::BaseController < ApplicationController
  http_basic_authenticate_with name: ENV["ADMIN_ID"], password: ENV["ADMIN_PW"]
end
