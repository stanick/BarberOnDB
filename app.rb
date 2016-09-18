require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

db = SQLite3::Database.new 'BarberShop.sqlite'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end

get '/about' do
	erb :about
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end


post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	# хеш
	hh = { 	:username => 'Введите имя',
			:phone => 'Введите телефон',
			:datetime => 'Введите дату и время' }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :visit
	end

	db.execute "insert into users (name, phone, datestamp, barber) 
					values ('#{@username}', '#{@phone}', '#{@datetime}', '#{@barber}')"

	db.close
	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}"


end

post '/contacts' do

	@email = params[:email]
	@message = params[:message]

	# хеш
	hh = { 	:email => 'Введите email',
		:message => 'Введите сообщение' }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ''
		return erb :contacts
	end

	db.execute "insert into contacts (email, message) values ('#{@email}', '#{@message}')"
	db.close
	erb "OK, email is #{@email}, message #{@message}"

end
