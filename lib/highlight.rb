require 'tempfile'

# snippet highlight
class Highlight    
  def self.format(code,type)
    result = ''
    tmpfile = nil
    begin
      tmpfile = Tempfile.new('twpaste')
      tmpfile.puts(code)
      tmpfile.flush
      result = `pygmentize -f html -l #{type} -O encoding=utf8,linenos=1 #{tmpfile.path}`
      result.gsub!('class="highlight"','class="highlight hldefault"')
      if $? != 0
        result = code
      end
    ensure
      tmpfile.close if tmpfile
    end
    result
  end
end
