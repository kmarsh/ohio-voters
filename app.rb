#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "sinatra"
require "sequel"

DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite:///data/voters.db")
VOTERS = DB[:voters]

get "/" do
  "<h1>#{VOTERS.count} Ohio Voters</h1>"
end

get "/:name" do
  "<h1>Hello From Ruby on Fly!</h1></br>and hello to #{params[:name]}"
end
