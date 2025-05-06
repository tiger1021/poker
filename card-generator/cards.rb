require 'rmagick'

card_height = 350
card_width = 250
#card_radius = 0.137795

["♥","♠","♦","♣"].each_with_index do | suit, index |
    (1..13).each do | value |
        card = Magick::Image.new(card_width,card_height) { |options| options.background_color = "Transparent" }

        if (value == 1)
            value = "A"
        elsif (value == 11)
            value = "J"
        elsif (value == 12)
            value = "Q"
        elsif (value == 13)
            value = "K"
        end
        stroke_width = 3
        modified_stroke_width = stroke_width/3
        card_background = Magick::Draw.new
        card_background.stroke = "Black"
        card_background.fill = "White"
        card_background.stroke_width = stroke_width
        card_background.roundrectangle(modified_stroke_width,modified_stroke_width, card_width-modified_stroke_width,card_height-modified_stroke_width, 8, 8)
        card_background.draw(card)

        identifier = Magick::Draw.new
        card.annotate(identifier, 0,0,0,0, value.to_s) do
            identifier.gravity = Magick::CenterGravity # Text positioning
            identifier.pointsize = 200 # Font size
            if (index%2 == 0)
                identifier.fill = "Red"
            else
                identifier.fill = "Black"
            end
            identifier.font = "ShipporiMinchoB1-Bold"
            identifier.font_weight = 900
            identifier.kerning = -10
            identifier.interline_spacing = 0
            
        end

        card.annotate(identifier, 0,0,10,-10, suit) do
            identifier.gravity = Magick::SouthEastGravity # Text positioning
            identifier.pointsize = 120 # Font size
            if (index%2 == 0)
                identifier.fill = "Red"
            else
                identifier.fill = "Black"
            end
            identifier.font = "ShipporiMinchoB1-Bold"
            identifier.font_weight = 900
            identifier.interline_spacing = 0
        end
        card.annotate(identifier, 0,0,10,-25, suit) do
            identifier.gravity = Magick::NorthWestGravity # Text positioning
            identifier.pointsize = 120 # Font size
            if (index%2 == 0)
                identifier.fill = "Red"
            else
                identifier.fill = "Black"
            end
            identifier.font = "ShipporiMinchoB1-Bold"
            identifier.font_weight = 900
            identifier.interline_spacing = 0
        end

        card.write("../cards/pngs/#{value}#{suit}.png")
    end
end