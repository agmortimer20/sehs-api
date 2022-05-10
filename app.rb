require "csv"
require "sinatra/base"
require "sinatra/json"
require "sinatra/reloader"

class App < Sinatra::Base
    configure :development do
        register Sinatra::Reloader
    end

    get "/" do
        "Sehs.dev Sample Data API"
    end

    get "/data/baby-names" do
        filepath = File.join(settings.public_folder, "baby-names.csv")
        data = []
        
        CSV.foreach(filepath, headers: true) do |row|
            data.push year: row[0].to_i, name: row[1], percent: row[2].to_f, sex: row[3]
        end

        data.to_json
    end
end