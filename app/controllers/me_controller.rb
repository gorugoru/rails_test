class MeController < ApplicationController
  before_filter :require_login
end
