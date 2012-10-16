require 'sinatra'
require 'data_mapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/recall.db")

class Note
  include DataMapper::Resource
  property :id, Serial
  property :content, Text, :required => true
  property :classomplete, Boolean, :required => true, :default => 0
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.auto_upgrade!

get '/' do
  @notes = Note.all :order => :id.desc
  @title = 'All Notes'
  erb :home
end

post '/' do
  n = Note.new
  n.content = params[:content]
  n.created_at = Time.now
  n.updated_at = Time.now
  n.save
  redirect '/'
end
