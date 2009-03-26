namespace :db do
  desc "Equivalent to db:seed:soft"
  task :seed => :environment do
    Rake::Task['db:seed:soft'].invoke
  end
  
  namespace :seed do
    desc "Recreate the database using schema.rb and additional migrations, then fill it with seed data."
    task :soft => :environment do
      raise "Hey, development only you monkey!" unless RAILS_ENV == 'development'
      Rake::Task['db:schema:load'].invoke
      Rake::Task['db:migrate'].invoke
      Rake::Task['db:seed:data'].invoke
    end

    desc "Recreate the database from scratch, then fill it with seed data."
    task :hard => :environment do
      raise "Hey, development only you monkey!" unless RAILS_ENV == 'development'
      Rake::Task['db:migrate:reset'].invoke
      Rake::Task['db:seed:data'].invoke
    end
    
    desc "Fill database with seed data."
    task :data => :environment do
      raise "Hey, development only!" unless RAILS_ENV == 'development'
      
      # create seed data
      puts "Creating users..."
      hmans = User.create!(:login => "hmans", :email => "hendrik@mans.de", :password => "moocow")
      kohlhofer = User.create!(:login => "alex", :email => "kohlhofer@gmail.com", :password => "alexpass")
      
      # create a bunch of pairs
      puts "Creating pairs..."
      [
        ['Star Trek', 'Star Wars'], ['Well connected', 'Peace and quiet'], ['Naughty', 'Nice'],
        ['Tidy', 'Chaos'], ['Energy Drinks!', 'Eeewwwwwww'], ['Coffee', 'Tea'], ['Rock', 'Pop'],
        ['Money', 'Happiness'], ['No more Internet', 'No more sex'], ['DVD', 'Cinema'],
        ["McDonald's", 'Burger King'], ['Rails', 'Java'],
        ['Mac', 'PC'], ['Agile', 'Waterfall'], ['City trip', 'Beach & sun'],
        ['High-brow', 'Low-brow'], ['Search', 'Find'], ['Love', 'Be loved'],
        ['Computer games are art', "No, they're not"],
        ['Quentin Tarantino', 'Robert Rodriguez']
      ].each do |items|
        hmans.pairs.create!(:items => items)
      end
      kohlhofer.pairs.create!(:items => ['Pay', 'Free'])
      kohlhofer.pairs.create!(:items => ['HAML', 'ERb'])
      kohlhofer.pairs.create!(:items => ['Skype', 'iChat'])
    end
  end
end
