Shoes.setup do
  gem 'rest-client >= 1.6.7'
end

require 'fluid'

Shoes.app do
  background "#FFFFFF"

  @stroke = []
  @strokes = []
  
  @lines = [];
  
  motion do |left, top|
    button = mouse[0]
    
    if (button == 1)
      unless @stroke.empty?
        @lines << line(@stroke.last[:x], @stroke.last[:y], left, top)
      end
      
      @stroke << {:x => left, :y => top}
    end
    
  end

  release do |button, left, top|
    if (button == 1)
      @strokes  << @stroke
      @stroke = []
    end
  end

  button("clear").click {
    @lines.each(&:remove)
    @stroke = []
    @strokes = []
  }
  
  button("submit").click {
    latex = Fluid.ocr(@strokes)
    @preview.path = Fluid.preview(latex)
    
    debug latex
    debug @preview.path
  }

  para "Preview:", :margin_left => 10, :margin_right => 15
  @preview = image(:margin_top => 8)
  
end
