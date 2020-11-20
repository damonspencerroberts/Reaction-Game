require 'ruby2d'

set({
    background: "silver",
    title: "Reaction Game"
})

game_started = false
square = nil
start_time = nil
end_time = nil
tries = []
counting_counter = 7

text = Text.new('This is a reaction game!', x: 20, y: 20)
text.color = "black"
text2 = Text.new('Click to begin', x: 20, y: 50)
text2.color = "black"


on :mouse_down do |event|  
    if counting_counter > -1
        if game_started
            if square.contains?(event.x, event.y)
                final_time = ((Time.now - start_time)*1000).round
                tries << final_time
                square.remove
                text = Text.new("You took #{final_time} ms. You're best 3 scores are #{tries.sort[0..2].join(", ")} ms.", x: 20, y: 20) 
                text2 = Text.new("Click to go again! #{counting_counter} more turns left.", x: 20, y: 50)
                text.color = "black"
                text2.color = "black"
            else
                square.remove
                text = Text.new("You didnt click the square.", x: 20, y: 20)
                text2 = Text.new("Click and Try again", x: 20, y: 50)
                text.color = "black"
                text2.color = "black"
                tries << Float::INFINITY
                
            end
            counting_counter -= 1
            game_started = false
            
        else
            text.remove
            text2.remove
            square = Square.new(
                x: rand(get(:width) - 25), y: rand(get(:height) - 25),
                size: 40,
                color: "purple"
            )
            start_time = Time.now
            game_started = true
        end 
    else
        text.remove
        text2.remove
        text = Text.new("Thank you for playing your best score was #{tries.sort[0]} milliseconds.", x:20, y:20)
        text2 = Text.new("Click to go again!", x: 20, y: 50)
        text.color = "black"
        text2.color = "black"

        game_started = false
        square = nil
        start_time = nil
        end_time = nil
        tries = []
        counting_counter = 7
    end
end






show