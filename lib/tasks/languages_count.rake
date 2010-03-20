namespace :db do 

    desc "update pastes count of languages"
    task :update_pastes_count => :environment do
         ActiveRecord::Base.establish_connection(RAILS_ENV.to_sym)
         languages = Language.all
         languages.each do |language|
	   pastes_count = language.pastes.count
           Language.update_counters language.id, :pastes_count => pastes_count
	   puts "language #{language.slug} pastes count is : #{pastes_count}"
         end
    end

end