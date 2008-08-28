require 'builder'

class BuilderWrapper
  attr_accessor :xml

  def initialize
    @output = ''
    @xml = Builder::XmlMarkup.new(:target => @output, :indent => 2 )
    @xml.instruct! :xml, :version => "1.1", :encoding => "US-ASCII"
  end

  def to_s
    @output
  end

  def log(hash)
    eval <<-EOS
      @xml.#{hash[:class]}(#{format_hash(hash) if hash[:action] == :start}) 
    EOS
  end
  def format_hash(hash)
    ret = '{' 
    hash.each_pair { |key, value| ret += ":#{key} => '#{value}', "}
    return ret + '}'
  end

end
