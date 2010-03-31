#require 'tempfile'
# paste highlight
class Highlight    
  def self.format(code,type)
    result = ''
    #tmpfile = nil
    #begin
      #tmpfile = Tempfile.new('twpaste')
      #tmpfile.puts(code)
      #tmpfile.flush
      #result = `pygmentize -f html -l #{type} -O encoding=utf8,linenos=1 #{tmpfile.path}`
      #if $? != 0
      # result = code
      #else
      #  result.gsub!('class="highlight"','class="highlight hldefault"')
      #end
    #ensure
    #  tmpfile.close if tmpfile
    #end

    IO.popen("pygmentize -f html -l #{type} -O encoding=utf8,linenos=1", 'r+') do |pipe|
      pipe.print code
      pipe.flush
      pipe.close_write
      result = pipe.read
      pipe.close_read
    end
    if $? != 0
      result = code
    else
      result.gsub!('class="highlight"','class="highlight hldefault"')
    end
    result
  end

  def self.format_without_linenos(code,type)
    result = ''
    IO.popen("pygmentize -f html -l #{type} -O encoding=utf8", 'r+') do |pipe|
      pipe.sync  = true
      pipe.print code
      pipe.close_write
      result = pipe.read
      pipe.close_read
    end
    if $? != 0
      result = code
    else
      result.gsub!('class="highlight"','class="highlight hldefault"')
    end
    result
  end

end
