require 'csv'   

namespace :populate do
  desc "populate from csv"
  task csv: :environment do
    import_from_csv
  end
end




def import_from_csv
  headers = [
    "name",
    "lat",
    "lng"     
  ]
 
  CSV.foreach("db/data.csv", {headers: false}) do |row|
    bar = Location.new

    headers.each_with_index do |key, idx|
      bar.send("#{key}=", row[idx])
    end
    bar.save
  end
end
