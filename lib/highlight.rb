require 'systemu'
require 'tempfile'
require 'string'

# snippet highlight
class Highlight    
  def self.format(code,type)
    result = ''
    tmpfile = nil
    begin
      tmpfile = Tempfile.new('twpaste')
      #tmpfile.binmode
      tmpfile.puts code
      result = systemu("pygmentize -f html -l #{type} -O encoding=utf8,linenos=1 #{tmpfile}")
    ensure
      tmpfile.close if tmpfile
    end
    return result[1]
  end
end
