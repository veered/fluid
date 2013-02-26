require 'cgi'

module Fluid

  def self.preview(latex)
    "http://latex.codecogs.com/gif.latex?#{CGI.escape(latex)}"
  end
  
end
