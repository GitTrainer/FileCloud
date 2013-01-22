class User
 attr_accessor :name, :email
 def initialize (attribuites={})
 @name=attribuites[:name]
 @email=attribuites[:email]
 end
 def formatted_email
 "#{@name} <#{@email}>"
 end
end