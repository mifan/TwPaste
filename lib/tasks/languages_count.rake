namespace :db do 

    desc "update pastes count of languages"
    task :update_pastes_count => :environment do
         ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
         languages = Language.all
         languages.each do |lang|
           psc = lang.pastes.count
	   lang.pastes_count = psc
	   lang.save!
	   puts "language #{lang.slug} pastes count is : #{psc}"
         end
    end

end