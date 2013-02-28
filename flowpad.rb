Shoes.setup do
  gem 'rest-client >= 1.6.7'
end

require 'fluid'

Shoes.app do

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
  

  stack do

    flow :height => 60 do
      background "#FFFFFF"

      clear_button = flow(:width => 0.3, :height => 60) do
        background '#990000'
      end
      clear_button.click {
        @lines.each(&:remove)
        @stroke = []
        @strokes = []
      }
      
      submit_button = flow(:width => 0.3, :height => 60) do
        background '#009900'
      end
      submit_button.click {
        unless @strokes.empty?
          latex = Fluid.ocr(@strokes)
          @preview.path = Fluid.preview(latex)
        end
      }

      flow :width => 0.3, :margin_left => 10 do 
        @preview = image :margin_top => 8
      end
      
    end
    
    flow do
      background "#FFFFFF"
    end

  end
  
end
