# -*- coding: utf-8 -*-
require 'spec_helper'
require 'rack/test'

require './massr'

describe "Massr::Routes::Auth" do
	include Rack::Test::Methods

	def app
		Massr::App
	end

	describe "ユーザ認証前" do

		context '/login' do
			it "GET" do
				get '/login'
				last_response.should be_ok
			end
		end

		context '/logout' do
			it "GET" do
				get '/logout'
				last_response.redirection?
			end
		end

		context '/unauthorized' do
			it "GET" do
				get '/unauthorized'
				last_response.should be_ok
			end
		end
	end

	describe "ユーザ認証後" do
		before :all do
			OmniAuth.config.test_mode = true
			OmniAuth.config.mock_auth[:twitter] = prototype_twitter(0)
			get '/auth/twitter'
			follow_redirect!
		end
		
		context '/logout' do
			it "GET" do
				get '/logout'
				last_response.should be_redirect
				session.size.should be(0)

			end
		end

		after :all do
			OmniAuth.config.test_mode = false
		end
	end
end

