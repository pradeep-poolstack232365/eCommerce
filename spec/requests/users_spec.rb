require 'rails_helper'

RSpec.describe "Users", type: :request do


  describe "GET /index" do
    # debugger
       @user = User.create(first_name:"pradeep",last_name:"kushwaha",email: "pradeep.kushwaha@poolstack.in", phone: "6260261764", password_digest: "123456")
      # debugger
      it "return a successful response" do 
        get "/users"

        # debugger
        data = JSON.parse(response.body)

        expect(response).to have_http_status(200)
      end
  end
  
  describe "POST /create" do
      it "data is created successfully"  do 
      post "/users", params:{first_name: "first", last_name: "last", email: "pradeep.kushwaha@poolstack.in", phone: "6260261764" , password: "123456", confirm_password: "123456"}
      expect(response).to have_http_status(200)
      end
      
      # it "data is not created" do 

      # post "/user", params:{first_name: "first", last_name: "last", email: "pradeep.kushwaha@poolstack.in", phone: "6260261764",password: "123456", confirm_password: "123456"}
      # expect(response).to have_http_status(401)
      # end
  end

end
