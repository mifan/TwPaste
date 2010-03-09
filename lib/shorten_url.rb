# snippet highlight
class ShortenUrl    
  def self.short_url(origin_url)
    bitly = Bitly.new('mifan', 'R_25b691a3c3e9adbf9405e8887f56b768')
    final_url = nil ;
    begin
      u = bitly.shorten(origin_url, :history => 1)
      final_url = u.jmp_ur
    rescue
      final_url = origin_url
    end
    final_url
  end
end