#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :barber, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	#@barbers=Barber.order "created_at DESC"
	@barbers=Barber.all
	@contacts=Contact.all
end

get '/' do
	erb :index
end

get '/visit' do
	@row=Client.new
	erb :visit
end

post '/visit' do
	@row=Client.new params[:client]
	if @row.save
		erb "<h2>Спасибо, вы записались!</h2>"
	else
		@error=@row.errors.full_messages.first
		erb :visit
	end
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
	@mail=params['email']
	@msg=params['message']

	hh={
		:email=>'Введите адрес электронной почты',
		:message=>'Введите сообщение'
	}

	hh.each do |key,val|
		if params[key]==""
			@error=hh[key]
			return erb :contacts
		end
	end

	Contact.create(mail: @mail, message: @msg)
	erb "<h2>Сообщение отправлено!</h2>"
end

get '/barber/:id' do
	@barber=Barber.find params[:id]
	erb :barber
end

get '/clients' do
	@clients=Client.order 'created_at DESC'
  erb :clients
end
