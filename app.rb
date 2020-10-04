#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	#@barbers=Barber.order "created_at DESC"
	@barbers=Barber.all
	@clients=Client.all
	@contacts=Contact.all
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@user_name=params['user_name']
	@phone=params['phone']
	@date_time=params['date_time']
	@barber=params['barber']
	@color=params['color']

	Client.create(name: @user_name, phone: @phone, datestamp: @date_time, barber: @barber, color: @color)

	erb "<h2>Спасибо, вы записались!</h2>"
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
