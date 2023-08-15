def show_menu
  puts
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all music albums'
  puts '3 - List of games'
  puts '4 - List all genres'
  puts '5 - List all labels'
  puts '6 - List all authors'
  puts '7 - Add a book'
  puts '8 - Add a music album'
  puts '9 - Add a game'
  puts '10 - Exit'

  user_choice = gets.chomp.to_i
  select_option(user_choice)
end

def select_option(user_choice)
  case user_choice

  when 1...6
    list_item(user_choice)


  when 7...9
    add_item(user_choice)

  when 10
    exit

  else
    puts 'Invalid input, please try again'
    show_menu
  end
end

def list_item(user_choice)
  case user_choice
  when 1 then puts ' # list_all_books'
  when 2 then puts ' # list_all_music_albums'
  when 3 then puts ' # list_all_games'
  when 4 then puts ' # list_all_genres'
  when 5 then puts ' # list_all_labels'
  when 6 then puts ' # list_all_authors'
  end
  show_menu
end

def add_item(user_choice)
  case user_choice
  when 7 then puts '# add_book'
  when 8 then puts '# add_music_album'
  when 9 then puts '# add_game'
  end
  show_menu
end

def exit
  puts 'Goodbye!'
end

def main
  show_menu
end

main
