require 'sinatra/base'
require "omniauth"
require "omniauth-salesforce"

class MyApp < Sinatra::Base

	configure do
		enable :logging
		enable :sessions
		set :session_secret, ENV['SECRET']
	end

	use OmniAuth::Builder do
		provider :salesforce, ENV['SALESFORCE_KEY'], ENV['SALESFORCE_SECRET']
	end

	get '/authenticate' do
	    redirect "/auth/salesforce"
	end

	get '/auth/salesforce/callback' do
		logger.info "#{env["omniauth.auth"]["extra"]["display_name"]}
		authenticated"
		env["omniauth.auth"]["extra"]["display_name"]
	end

	get '/auth/failure' do
		params[:message]
	end
	
	get '/unauthenticate' do
		session.clear
		'Goodbye - you are now logged out'
	end

    get '/' do
    	logger.info "Visited home page"
    	'Home 2'
	end
    
    get '/hello' do
       'Hello World'
	end
    
    run! if app_file == $0

end