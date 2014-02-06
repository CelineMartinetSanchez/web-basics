get '/' do
	@albums_list = Album.list
	erb :index
end

get '/new' do
	@album = Album.new
  @post_url = '/'
  erb :form
end

post '/' do
	Album.new(params[:album]).save
  redirect to('/')
end

get '/:id' do 
  # Find the album with index :id and transmit it to the show view
  @album = Album.find(params[:id].to_i)
  @albums_list = Album.list
  erb :show
end

get '/:id/edit' do
	@album = Album.find(params[:id].to_i)
	@post_url = "/#{params[:id]}"
  erb :form
end

post '/:id' do
	Album.find(params[:id].to_i).update(params[:album])
  redirect to('/')
end

get '/:id/delete' do
	Album.find(params[:id].to_i).delete
	redirect to('/')
end