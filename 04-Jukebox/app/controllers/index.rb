get '/' do
	@albums_list = Album.list
	erb :index
end

get '/new' do
	@album = Album.new
	@url = ""
  erb :form
end

post '/' do
	Album.new(params[:album]).save
  redirect to('/')
end

get '/:id' do 
  @album = Album.find(params[:id].to_i)
  erb :show
end

get '/:id/edit' do
	@album = Album.find(params[:id].to_i)
	@url = "#{params[:id]}"
	erb :form
end

post '/:id' do
	@album = Album.find(params[:id].to_i)
	@album.update(params[:album])
	redirect to('/')
end

get '/:id/delete' do
	@album = Album.find(params[:id].to_i)
	@album.delete
	redirect to('/')
end