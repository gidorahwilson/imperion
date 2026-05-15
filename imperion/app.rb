require 'sinatra'
require 'mysql2'

set :bind, '0.0.0.0'
set :port, 3000

set :protection, false

# Koneksi MySQL
 DB = Mysql2::Client.new(
   host: "localhost",
   username: "root",
   password: "root",
   database: "sinatra_app"
 )

get '/' do
  erb :home
end

get '/about' do
  erb :about
end

get '/kontak' do
  erb :kontak
end

get '/top-download' do
  erb :topdownload
end

get '/Games' do
  erb :games
end

get '/akun' do
  erb :akun
end

post "/login-akun" do

  name  = params[:name]
  email = params[:email]

  result = DB.query("SELECT * FROM users2 WHERE name='#{name}' AND email='#{email}'")

  if result.count > 0
    redirect "/Games"
  else
    @error = "Login gagal!"
    erb :akun
  end
end

get '/register' do
  erb :register
end

post "/register-user" do

  name  = params['name']
  email = params['email']

  sql = "INSERT INTO users2 (name,email) VALUES ('#{name}','#{email}')"

  DB.query(sql)
  erb :register
end

get '/index' do
  erb :index
end

post "/login" do

  name  = params[:name]
  email = params[:email]

  result = DB.query("SELECT * FROM users WHERE name='#{name}' AND email='#{email}'")

  if result.count > 0
    redirect "/dashboard"
  else
    @error = "Login gagal!"
    erb :index
  end
end

get "/dashboard" do
  erb :dashboard
end

get "/users2" do
  erb :users2
end

#post "/tambah" do

 #name  = params['name']
 #email = params['email']

  #sql = "INSERT INTO users2 (name,email) VALUES ('#{name}','#{email}')"

  #DB.query(sql)

  #erb :users2
#end

get "/data" do

  daftar = "select * from users2"

  @hasil =  DB.query(daftar)

  erb :data
end

get "/hapus/:name" do
  name = params['name']

  DB.query("DELETE FROM users2 WHERE name='#{name}'")

  @hasil = DB.query("SELECT * FROM users2")

  erb :data
end
