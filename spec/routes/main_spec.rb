# -*- coding: utf-8 -*-
require 'spec_helper'
require 'rack/test'

require 'routes/init'

describe "Massr:Routes::Main" do
	include Rack::Test::Methods

	def app
		Massr::App
	end

	describe "ユーザ認証後" do
		context '/' do
			it "GET" do
				get '/'
				last_response.should be_redirect
			end
		end
	end
	
	describe "ユーザ認証後" do
		before :all do
			OmniAuth.config.test_mode = true
			OmniAuth.config.mock_auth[:twitter] = prototype_twitter(0)
			get '/auth/twitter'
			follow_redirect! # '/auth/twitter/callback' へ
			follow_redirect! # '/usre' へ 
		end

		context '/' do
			it "GET" do
				get '/'
				#last_response.should be_ok
			end
		end

		after :all do
			OmniAuth.config.test_mode = false
		end
	end

end

