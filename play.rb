require 'ruby2d'

set({
    background: "silver",
    title: "Reaction Game"
})

game_started = false
square = nil
start_time = nil
end_time = nil
tries1 = []
tries2 = []
counting_counter = 7
player = 0

text = Text.new('This is a reaction game!', x: 20, y: 20)
text.color = "black"
text2 = Text.new('Click to begin', x: 20, y: 50)
text2.color = "black"
text3 = Text.new("Player 1's Turn", x: 20, y: 80)
text3.color = "black"

on :mouse_down do |event|  
    if counting_counter > -1
        if game_started
            if square.contains?(event.x, event.y)
                final_time = ((Time.now - start_time)*1000).round
                player == 0 ? tries1 << final_time : tries2 << final_time
                square.remove
                text = Text.new("#{player == 0 ? "Player 1" : "Player 2"} took #{final_time} ms. #{player == 0 ? "Player 1" : "Player 2"} best 3 scores are #{player == 0 ? tries1.sort[0..2].join(", ") : tries2.sort[0..2].join(", ")} ms.", x: 20, y: 20) 
                text2 = Text.new("Next! #{counting_counter} more turns left.", x: 20, y: 50)
                text3 = Text.new("#{player == 0 ? "Player 2's Turn" : "Player 1's Turn"}. Their best score is #{player == 1 ? tries1.sort[0] : tries2.sort[0]} ms.", x: 20, y: 80)
                text.color = "black"
                text2.color = "black"
                text3.color = "black"
            else
                square.remove
                text = Text.new("#{player == 0 ? "Player 1" : "Player 2"} didnt click the square.", x: 20, y: 20)
                text2 = Text.new("Next! #{counting_counter} more turns left.", x: 20, y: 50)
                text3 = Text.new("#{player == 0 ? "Player 2's Turn" : "Player 1's Turn"}. Their best score is #{player == 1 ? tries1.sort[0] : tries2.sort[0]} ms.", x: 20, y: 80)
                text.color = "black"
                text2.color = "black"
                text3.color = "black"
                player == 0 ? tries1 << Float::INFINITY : tries2 << Float::INFINITY 
            end

            player == 1 ? counting_counter -= 1 : counting_counter = counting_counter
            player == 0 ? player = 1 : player = 0
            game_started = false
            
        else
            text.remove
            text2.remove
            text3.remove
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
        text3.remove
        text = Text.new(tries1.sort[0] < tries2.sort[0] ? "Player 1 Wins with #{tries1.sort[0]} milliseconds!" : "Player 2 Wins with #{tries2.sort[0]} milliseconds.", x: 20, y: 20)
        text2 = Text.new("Thank you for playing!", x: 20, y: 50)
        text3 = Text.new("Click to go again!", x: 20, y: 80)
        text.color = "black"
        text2.color = "black"
        text3.color = "black"

        game_started = false
        square = nil
        start_time = nil
        end_time = nil
        tries1 = []
        tries2 = []
        counting_counter = 7
        player = 0
    end
end






show