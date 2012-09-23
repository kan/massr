# -*- coding: utf-8 -*-
#
# spec_helper.rb
#
# Copyright (C) 2012 by The wasam@s production
# https://github.com/tdtds/massr
#
# Distributed under GPL
#

$:.unshift File.expand_path(File.join(File.dirname(__FILE__), '..')).untaint
Bundler.require :test if defined?(Bundler)

RSpec.configure do |config|
	require 'mongo_mapper'
	MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
	MongoMapper.database = 'massr_test'
	config.before(:each) do
		MongoMapper.database.collections.each {|collection| collection.remove}
	end
end

def session
  last_request.env['rack.session']
end

def prototype_user(no)
	[
		{
			:massr_id => 'wasamas',
			:twitter_id => '1234567',
			:twitter_icon_url => 'http://example.com/foo1.png',
			:name => 'わさます',
			:email => 'wasamas@example.com',
		},
		{
			:massr_id => 'wasamas2',
			:twitter_id => '7654321',
			:twitter_icon_url => 'http://example.com/foo2.png',
			:name => 'わさます2',
			:email => 'wasamas2@example.com',
		}
	][no]
end

def prototype_statement(no,user)
	[
		{
			# 元エントリ用
			:body  => 'ほんぶんだよ！',
			:photo => 'http://example.com/foo.jpg',
			:user  =>  user
		},
		{
			# レスエントリ用
			:body  => 'ほんぶんだよ２！',
			:photo => 'http://example.com/baa.jpg',
			:user  => user
		}
	][no]
end

def prototype_twitter(no)
	[
		{
			:provider  => 'twitter',
			:uid => '1234567890',
			'extra'  =>  {
				'raw_info' => {
					'name' => 'twitter_user_name',
					'screen_name' => 'twitter_screen_name',
					'profile_image_url' => 'http://example.com/twitter_icon_url.png'
				}
			}
		}
	][no]
end

