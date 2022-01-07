#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "sinatra"

get "/" do
  "<h1>Hello From Ruby on Fly!</h1>"
end

get "/:name" do
  "<h1>Hello From Ruby on Fly!</h1></br>and hello to #{params[:name]}"
end
