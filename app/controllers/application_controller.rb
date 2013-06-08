class ApplicationController < ActionController::Base
  protect_from_forgery
  if Rails.env.development? 
  	require 'pry'
  end
end
