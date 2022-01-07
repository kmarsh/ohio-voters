#!/usr/bin/env ruby
require "rubygems"
require "bundler/setup"
require "sinatra"
require "sequel"

DB = Sequel.connect(ENV["DATABASE_URL"] || "sqlite:///data/voters.db")
VOTERS = DB[:voters]

helpers do
  def age(dob)
    dob = Date.parse(dob) unless dob.is_a?(Date)

    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end
end

get "/" do
  if (last_name = params[:last_name].to_s.strip) != ""
    @voters = VOTERS.where(Sequel.ilike(:LAST_NAME, "%#{last_name}%"))
                    .order(:first_name)
  elsif (address = params[:address].to_s.strip) != ""
    @voters = VOTERS.where(Sequel.ilike(:RESIDENTIAL_ADDRESS1, "%#{address}%"))
                    .order(:residential_address1)
  end

  erb :'index', layout: true
end

get '/voters/:id' do
  @voter = VOTERS.where(SOS_VOTERID: params[:id])
                .first

  erb :'show', layout: true
end
