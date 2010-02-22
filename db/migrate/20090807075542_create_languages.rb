class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name, :null => false
      t.string :slug, :null => false
      t.string :description, :null => false
      t.integer :snippets_count, :null => false, :default => 0

      t.timestamps
    end

    # init languages data
    languages = [
            {:name => "Action Script",:slug => "javascript", :snippets_count => 0},
            {:name => "C",:slug => "c", :snippets_count => 0},
            {:name => "C++",:slug => "cpp", :snippets_count => 0},
            {:name => "CSS",:slug => "css", :snippets_count => 0},
            {:name => "Delphi",:slug => "delphi", :snippets_count => 0},
            {:name => "Diff",:slug => "diff", :snippets_count => 0},
            {:name => "Ecma Script",:slug => "javascript", :snippets_count => 0},
            {:name => "Groovy",:slug => "groovy", :snippets_count => 0},
            {:name => "HTML",:slug => "html", :snippets_count => 0},
            {:name => "HTML Ruby (.erb)",:slug => "rhtml", :snippets_count => 0},
            {:name => "Java",:slug => "java", :snippets_count => 0},
            {:name => "JavaScript",:slug => "javascript", :snippets_count => 0},
            {:name => "JSON",:slug => "json", :snippets_count => 0},
            {:name => "Nitro XHTML",:slug => "xhtml", :snippets_count => 0},
            {:name => "Pascal",:slug => "delphi", :snippets_count => 0},
            {:name => "PHP",:slug => "php", :snippets_count => 0},
            {:name => "Plain text",:slug => "plain", :snippets_count => 0},
            {:name => "Python",:slug => "python", :snippets_count => 0},            
            {:name => "RHTML",:slug => "rhtml", :snippets_count => 0},
            {:name => "Ruby",:slug => "ruby", :snippets_count => 0},
            {:name => "Scheme",:slug => "scheme", :snippets_count => 0},
            {:name => "SQL",:slug => "sql", :snippets_count => 0},
            {:name => "XML",:slug => "xml", :snippets_count => 0},
            {:name => "XHTML",:slug => "html", :snippets_count => 0},
            {:name => "YAML",:slug => "yaml", :snippets_count => 0}
            ]
    languages.each do |l|
       Language.new(l).save
    end
  end

  def self.down
    drop_table :languages
  end
end
