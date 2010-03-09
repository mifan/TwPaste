class CreateLanguages < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :name, :null => false
      t.string :slug, :null => false
      t.string :description, :null => true
      t.integer :pastes_count, :null => false, :default => 0

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
      {:name => "Scala",:slug => "scala", :description => 'Scala is a general purpose programming language designed to express common programming patterns in a concise, elegant, and type-safe way.'},
      {:name => "C#",:slug => "csharp", :description => 'C# is a type-safe, object-oriented language that is simple yet powerful, allowing programmers to build a breadth of applications.'},
      {:name => "VB.NET",:slug => "vbnet", :description => 'Visual Basic .NET (VB.NET) is an object-oriented computer programming language that can be viewed as an evolution of Microsoft\'s  Visual Basic (VB) which is generally implemented on the Microsoft .NET Framework.'},
      {:name => "Lisp",:slug => "common-lisp", :description => 'Lisp (or LISP) is a family of computer  programming languages with a long history and a distinctive, fully parenthesized syntax.'},
      {:name => "Erlang",:slug => "erlang", :description => 'Erlang is a general-purpose programming language and runtime environment. Erlang has built-in support for concurrency, distribution and fault tolerance.'},
      {:name => "Haskell",:slug => "haskell", :description => 'Haskell is an advanced purely functional programming language. An open source product of more than twenty years of cutting edge research, it allows rapid development of robust, concise, correct software.'},
      {:name => "Scheme",:slug => "schema", :description => 'Scheme is one of the two main dialects of the programming language Lisp. Unlike Common Lisp, the other main dialect, Scheme follows a minimalist design philosophy specifying a small standard core with powerful tools for language extension.'},


      {:name => "Matlab",:slug => "matlab", :description => 'MATLAB is a numerical computing environment and fourth generation programming language.'},


      {:name => "Apple Script",:slug => "applescript", :description => 'AppleScript is a scripting language created by Apple. It allows users to directly control scriptable Macintosh applications, as well as parts of Mac OS X itself.'},
      {:name => "Bash",:slug => "bash", :description => 'Bash is a free software Unix shell written for the GNU Project.'},
      {:name => "Batch",:slug => "bat", :description => 'DOS/Windows Batch file.'},
      {:name => "MySql",:slug => "mysql", :description => 'MySQL sql.'},
      {:name => "Smalltalk",:slug => "smalltalk", :description => 'Smalltalk is a computer language designed specifically for a wide range of humans rather than a narrow group of computer specialists.'},
      {:name => "SQL",:slug => "sql", :description => 'Structured Query Language.'},
      {:name => "Tcsh",:slug => "tcsh", :description => 'Tcsh is a Unix shell based on and compatible with the C shell (csh).'},
      {:name => "Tcsh",:slug => "tcsh", :description => 'Tcsh is a Unix shell based on and compatible with the C shell (csh).'},

      {:name => "Plain Text",:slug => "text", :description => 'Just text only.'},

      {:name => "Django",:slug => "django", :description => 'Django is a high-level Python Web framework that encourages rapid development and clean, pragmatic design.'},

      {:name => "JSP",:slug => "jsp", :description => 'Java Server Pages.'},
      {:name => "RHTML(html.erb)",:slug => "rhtml", :description => 'eRuby is a templating system that embeds Ruby into a text document. '},


      {:name => "Apache conf",:slug => "apacheconf", :description => 'Apache config file.'},
      {:name => "BBCode",:slug => "bbcode", :description => 'BBCode(-like)'},
      {:name => "Make",:slug => "make", :description => 'BSD and GNU make extensions'},
      {:name => "CMake",:slug => "cmake", :description => 'CMake, the cross-platform, open-source make system.'},
      {:name => "Diff",:slug => "diff", :description => 'In computing, diff is a file comparison utility that outputs the differences between two files.'},
      {:name => "Ini",:slug => "ini", :description => 'INI file, a configuration file for computer applications'},
      {:name => "Lighttpd conf",:slug => "lighttpd", :description => 'Lighttpd configuration file.'},
      {:name => "Nginx conf",:slug => "nginx", :description => 'Nginx configuration file.'},
      {:name => "Squid conf",:slug => "squidconf", :description => 'Squid configuration file.'},
      {:name => "TeX",:slug => "latex", :description => 'TeX and LaTeX typesetting languages.'},
      {:name => "Vim",:slug => "vim", :description => 'VimL script'},
      {:name => "YAML",:slug => "yaml", :description => 'YAML, a human-friendly data serialization language.'},


      {:name => "ActionScript 3",:slug => "actionscript3", :description => 'ActionScript 3'},
      {:name => "CSS",:slug => "css", :description => 'Cascading Style Sheets'},
      {:name => "HTML",:slug => "html", :description => 'HTML 4 and XHTML 1 markup'},
      {:name => "JavaScript",:slug => "javascript", :description => 'JavaScript'},
      {:name => "MXML",:slug => "mxml", :description => 'MXML markup'},
      {:name => "PHP",:slug => "php", :description => 'PHP is a widely-used general-purpose scripting language that is especially suited for Web development and can be embedded into HTML.'},
      {:name => "XML",:slug => "xml", :description => 'eXtensible Markup Language.'},
      {:name => "XSLT",:slug => "xslt", :description => 'xslt'}
    ]

    languages.each do |l|
       Language.new(l).save
    end
  end

  def self.down
    drop_table :languages
  end
end
