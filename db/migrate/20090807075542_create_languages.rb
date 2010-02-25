class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name, :null => false
      t.string :slug, :null => false
      t.string :description, :null => true
      t.integer :snippets_count, :null => false, :default => 0

      t.timestamps
    end

    # init languages data
    languages = [
      {:name => "Lua",:slug => "lua", :description => 'Lua is a powerful, fast, lightweight, embeddable scripting language'},
      {:name => "Perl",:slug => "perl", :description => 'Perl is a highly capable, feature-rich programming language'},
      {:name => "Python 3",:slug => "python3", :description => 'Python is a programming language that lets you work more quickly and integrate your systems more effectively(version 3.0)'},
      {:name => "Python",:slug => "python", :description => 'Python is a programming language that lets you work more quickly and integrate your systems more effectively'},
      {:name => "Ruby Console",:slug => "irb", :description => 'Ruby interactive console (irb)'},
      {:name => "Ruby",:slug => "ruby", :description => 'A dynamic, open source programming language with a focus on simplicity and productivity'},
      {:name => "Tcl",:slug => "tcl", :description => 'Tcl (Tool Command Language) is a very powerful but easy to learn dynamic programming language'},

      {:name => "Gas",:slug => "gas", :description => 'Gas (AT&T) assembly'},
      {:name => "NASM",:slug => "nasm", :description => 'The Netwide Assembler'},

      {:name => "C",:slug => "c", :description => 'C is a general-purpose computer programming language'},
      {:name => "C++",:slug => "cpp", :description => 'C is a general-purpose computer programming language'},
      {:name => "Cython",:slug => "cython", :description => 'Cython is a language that makes writing C extensions for the Python language as easy as Python itself'},
      {:name => "D",:slug => "d", :description => 'D is a systems programming language'},
      {:name => "Delphi",:slug => "delphi", :description => 'Delphi language, a set of object-oriented extensions to standard Pascal, is the language of Delphi'},
      {:name => "Fortran",:slug => "fortran", :description => 'Fortran is a general-purpose, procedural, imperative programming language that is especially suited to numeric computation and scientific computing'},
      {:name => "Go",:slug => "go", :description => 'A systems programming language expressive, concurrent, garbage-collected'},
      {:name => "Java",:slug => "java", :description => 'Java is a programming language originally developed by James Gosling at Sun Microsystems'},
      {:name => "Objective-C",:slug => "objective-c", :description => 'Objective-C is a reflective, object-oriented programming language, which adds Smalltalk-style messaging to the C programming language.'},
      {:name => "Prolog",:slug => "prolog", :description => 'Prolog is a general purpose logic programming language associated with artificial intelligence and computational linguistics.'},




 


      {:name => "ActionScript", :slug => "as3",  },    
      {:name => "Apache Config file (.conf)",:slug => "apacheconf",  },
      {:name => "AppleScript",:slug => "applescript",  },
                        {:name => "BBCode",:slug => "bbcode",  },
                        {:name => "Bash",:slug => "bash",  },
                        {:name => "Bash Session",:slug => "console",  },
                        {:name => "Windows Batchfile(.bat)",:slug => "bat",  },
                        {:name => "C",:slug => "c",  },
                        {:name => "C#",:slug => "csharp",  },
                        {:name => "C++",:slug => "cpp",  },
                        {:name => "CSS",:slug => "css",  },
                        {:name => "CSS Django",:slug => "css+django",  },
                        {:name => "CSS PHP",:slug => "css+php",  },
                        {:name => "CSS Ruby",:slug => "css+erb",  },
                        {:name => "CSS Smarty",:slug => "css+smarty",  },
                        {:name => "Cheetah",:slug => "cheetah",  },
                        {:name => "Common Lisp",:slug => "common-lisp",  },

                        {:name => "Cython",:slug => "cython",  },
                        {:name => "D",:slug => "d",  },
                        {:name => "Debian Control file",:slug => "control",  },
                        {:name => "Debian Sourcelist",:slug => "sourceslist",  },
                        {:name => "Delphi",:slug => "delphi",  },
                        {:name => "Diff",:slug => "diff",  },
                        {:name => "Django",:slug => "django",  },                        
                        {:name => "Erlang",:slug => "erlang",  },
                        {:name => "Fortran",:slug => "fortran",  },
                        {:name => "HTML",:slug => "html",  },
                        {:name => "HTML Ruby (.erb)",:slug => "erb",  },
                        {:name => "HTML Cheetah",:slug => "html+cheetah",  },
                        {:name => "HTML Django",:slug => "html+django",  },
                        {:name => "HTML PHP",:slug => "html+php",  },                        
                        {:name => "HTML Smarty",:slug => "html+smarty",  },
                        {:name => "Haskell",:slug => "haskell",  },
                        {:name => "INI",:slug => "ini",  },
                        {:name => "IRC logs",:slug => "irc",  },
                        {:name => "Java",:slug => "java",  },
                        {:name => "Java Server Page (.jsp)",:slug => "jsp",  },
                        {:name => "JavaScript",:slug => "js",  },
                        {:name => "JavaScript Cheetah",:slug => "js+cheetah",  },
                        {:name => "JavaScript Django",:slug => "js+django",  },
                        {:name => "JavaScript PHP",:slug => "js+php",  },
                        {:name => "JavaScript Ruby",:slug => "js+erb",  },
                        {:name => "JavaScript+Smarty",:slug => "js+smarty",  },
                        {:name => "LLVM",:slug => "llvm",  },
                        {:name => "Lighttpd configuration file",:slug => "lighty",  },
                        {:name => "Lua",:slug => "lua",  },
                        {:name => "Makefile",:slug => "make",  },
                        {:name => "MoinMoin/Trac Wiki markup",:slug => "trac-wiki",  },
                        {:name => "Nginx configuration file",:slug => "nginx",  },
                        {:name => "PHP",:slug => "php",  },
                        {:name => "Perl",:slug => "perl",  },
                        {:name => "Plain text",:slug => "text",  },
                        {:name => "Python",:slug => "python",  },                        
                        {:name => "RHTML",:slug => "rhtml",  },
                        {:name => "Ruby",:slug => "rb",  },
                        {:name => "Ruby irb session",:slug => "rbcon",  },
                        {:name => "Scala",:slug => "scala",  },
                        {:name => "Scheme",:slug => "scheme",  },
                        {:name => "Smalltalk",:slug => "smalltalk",  },
                        {:name => "Smarty",:slug => "smarty",  },
                        {:name => "Squid Config file",:slug => "squidconf",  },
                        {:name => "SQL",:slug => "sql",  },
                        {:name => "Tcl",:slug => "tcl",  },
                        {:name => "TeX",:slug => "tex",  },                        
                        {:name => "Vim file",:slug => "vim",  },
                        {:name => "XML",:slug => "xml",  },
                        {:name => "XSLT",:slug => "xslt",  },
                        {:name => "YAML",:slug => "yaml",  },
                        ]
    languages.each do |l|
       Language.new(l).save
    end
  end

  def self.down
    drop_table :languages
  end
end
