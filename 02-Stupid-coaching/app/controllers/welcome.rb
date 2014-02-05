get '/' do
  @coach_message = params[:coach_message] || "Tell me something!"
  # Look in app/views/index.erb
  
  puts "self : #{self}"
  puts "self class: #{self.class}"
  puts "self instance variables from GET '/' route handler: #{self.instance_variables}"
  erb :index
end



post '/coach' do
  answer = params[:what]

  if answer.end_with? "?"
	  @coach_message = "Silly question, get dressed and go to work"
	elsif answer.end_with? "!"
	  @coach_message = "I can feel your motivation son!"
	elsif answer == "I am going to work."
	  @coach_message ="Good boy!"
	else
	  @coach_message = "I don't care son. Tell me something else."
	end

	 erb :index
end