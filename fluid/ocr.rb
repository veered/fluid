require 'rest_client'
require 'json'

module Fluid

  def self.ocr(strokes)
    url = "http://webdemo.visionobjects.com/api/myscript/v1.0/equation/recognize.json"

    data = strokes.map do |stroke|
      {
        :x => stroke.map {|h| h[:x]},
        :y => stroke.map {|h| h[:y]}
      }
    end

    params = {
      :application => "webdemo.equation",
      :instanceUUID => "6DE3142D-F7C4-4B44-8DF5-EB803BAE12F6",
      :value => data
    }

    response = RestClient.post(url, "equationInput=#{params.to_json}")
    parsed = JSON.parse(response)
    
    parsed["latexResult"].strip
    
  end
  
end
