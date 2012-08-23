# -*- coding: utf-8; -*-
#
# massr.rb : Massr - Mini Wassr
#
# Copyright (C) 2012 by TADA Tadashi <t@tdtds.jp>
#

require 'sinatra/base'
require 'haml'
require 'json'
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-twitter'

module Massr

	
	class App < Sinatra::Base

		set :haml, { format: :html5, escape_html: true }

		configure :development do
			require 'pit'
			
			@auth_facebook = Pit::get( 'auth_facebook', :require => {
					:id => 'your APP ID of Facebook APP.',
					:secret => 'your APP Secret of Facebook APP.',
				} )
			@auth_twitter = Pit::get( 'auth_twitter', :require => {
					:id => 'your CUNSUMER KEY of Twitter APP.',
					:secret => 'your CUNSUMER SECRET of Twitter APP.',
				} )
		end

		use OmniAuth::Strategies::Facebook , @auth_facebook[:id] , @auth_facebook[:secret],:scope => 'user_about_me'
		use OmniAuth::Strategies::Twitter  , @auth_twitter[:id]  , @auth_twitter[:secret]

		enable :sessions

		get '/' do
			haml :index
		end

		get '/auth/:provider/callback' do
			info = request.env['omniauth.auth']
			"#{info['info']['name']}さんこんにちは！"
		end
	end
end

Massr::App::run! if __FILE__ == $0
