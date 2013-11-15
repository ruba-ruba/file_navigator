require 'csv'   

namespace :populate do
  desc "populate from csv"
  task csv: :environment do
    import_from_csv
  end
end

def import_from_csv
  csv_text = File.dirname(__FILE__) + File.read('data.csv')
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    Location.create!(row.to_hash)
  end
end