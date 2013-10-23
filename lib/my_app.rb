require 'grape'

module MyApp
  class API < Grape::API
    prefix "api"
    format :json
    default_format :json


    resource "items" do
      get "/size" do
        @size = Item.pluck(:item_file_size).inject{|sum,x| sum + x }
        #number_to_human_size(@size)
      end

      delete "/remove" do
        Item.where("item_file_name like (?)", "%.#{params[:type]}").destroy
      end
    end



  end
end
