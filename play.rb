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
tries1 = []
tries2 = []
counting_counter = 7
player = 0 
amount_start = nil


puts "1 or 2 player game?"
amount_start = gets.chomp.to_i

puts "Enter Player 1's Name:"
name1 = gets.chomp

if amount_start > 1
    puts "Enter Player 2's Name:"
    name2 = gets.chomp
end

text = Text.new('This is a reaction game!', x: 20, y: 20)
text.color = "black"
text2 = Text.new('Click to begin', x: 20, y: 50)
text2.color = "black"
text3 = Text.new("#{name1}'s Turn", x: 20, y: 80)
text3.color = "black"

if amount_start == 1
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
                    text2 = Text.new("Click and Try again #{counting_counter} more turns left.", x: 20, y: 50)
                    text.color = "black"
                    text2.color = "black"
                    tries << Float::INFINITY
                    
                end
                counting_counter -= 1
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
end

if amount_start == 2
    on :mouse_down do |event|  
        if counting_counter > -1
            if game_started
                if square.contains?(event.x, event.y)
                    final_time = ((Time.now - start_time)*1000).round
                    player == 0 ? tries1 << final_time : tries2 << final_time
                    square.remove
                    text = Text.new("#{player == 0 ? "#{name1}" : "#{name2}"} took #{final_time} ms. #{player == 0 ? "#{name1}" : "#{name2}"} best 3 scores are #{player == 0 ? tries1.sort[0..2].join(", ") : tries2.sort[0..2].join(", ")} ms.", x: 20, y: 20) 
                    text2 = Text.new("Next! #{counting_counter} more turns left.", x: 20, y: 50)
                    text3 = Text.new("#{player == 0 ? "#{name2}'s Turn" : "#{name1}'s Turn"}. Their best score is #{player == 1 ? tries1.sort[0] : tries2.sort[0]} ms.", x: 20, y: 80)
                    text.color = "black"
                    text2.color = "black"
                    text3.color = "black"
                else
                    square.remove
                    text = Text.new("#{player == 0 ? "#{name1}" : "#{name2}"} didnt click the square.", x: 20, y: 20)
                    text2 = Text.new("Next! #{counting_counter} more turns left.", x: 20, y: 50)
                    text3 = Text.new("#{player == 0 ? "#{name2}'s Turn" : "#{name1}'s Turn"}. Their best score is #{player == 1 ? tries1.sort[0] : tries2.sort[0]} ms.", x: 20, y: 80)
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
            text = Text.new(tries1.sort[0] < tries2.sort[0] ? "#{name1} Wins with #{tries1.sort[0]} milliseconds!" : "#{name2} Wins with #{tries2.sort[0]} milliseconds.", x: 20, y: 20)
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
end





show