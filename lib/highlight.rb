require 'string'
require 'coderay'

# snippet highlight
class Highlight
  def self.format(code,type)
    CodeRay.scan(code,type.to_sym).div
  end
end
