#require 'systemu'
require 'tempfile'
require 'string'

# snippet highlight
class Highlight    
  def self.format(code,type)
    result = ''
    tmpfile = nil
    begin
      tmpfile = Tempfile.new('twpaste')
      tmpfile.puts(code).flush
      result = `pygmentize -f html -l #{type} -O encoding=utf8,linenos=1 #{tmpfile.path}`
      if $? != 0
        result = code
      end
    ensure
      tmpfile.close if tmpfile
    end
    result
  end
end
