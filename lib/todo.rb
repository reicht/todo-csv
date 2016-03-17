require 'csv'

class Todo

  def initialize(file_name)
    @file_name = file_name #Don't touch this line or var
    # You will need to read from your CSV here and assign them to the @todos variable. make sure headers are set to true
    @todos = CSV.read(@file_name, {headers: true})
  end

  def start
    loop do
      system('clear')

      puts "---- TODO.rb ----"

      view_todos

      puts
      puts "What would you like to do?"
      puts "1) Exit 2) Add Todo 3) Mark Todo As Complete"
      puts "4) Delete Todo Item 5) Edit Todo Item"
      print " > "
      action = gets.chomp.to_i
      case action
      when 1
        save!
        exit
      when 2 then add_todo
      when 3 then mark_todo
      when 4 then delete_todo
      when 5 then edit_todo
      else
        puts "\a"
        puts "Not a valid choice"
      end
    end
  end

  def view_todos
    puts "Unfinished"
    @todos.each_with_index do |todo, index|
      completion = todo["completed"]
      if completion == "no"
        puts "#{index + 1}) #{todo["name"]}"
      end
    end
    puts "Completed"
    @todos.each_with_index do |todo, index|
      completion = todo["completed"]
      if completion == "yes"
        puts "#{index + 1}) #{todo["name"]}"
      end
    end
  end

  def add_todo
    puts
    puts "Name of Todo > "
    @todos << [get_input,"no"]
  end

  def mark_todo
    puts "Which todo have you finished?"
    target = @todos[get_input.to_i-1]
    if target["completed"] == "no"
      target["completed"] = "yes"
    end
  end

  def delete_todo
    puts "Which todo would you like to delete?"
    @todos.delete(get_input.to_i - 1)
  end

  def edit_todo
    puts "Which todo would you like to edit?"
    target = @todos[get_input.to_i-1]
    puts "Currently: " + target["name"]
    puts "What is the new Todo text?"
    target["name"] = get_input
  end

  def todos
    @todos
  end

  private # Don't edit the below methods, but use them to get player input and to save the csv file
  def get_input
    gets.chomp
  end

  def save!
    File.write(@file_name, @todos.to_csv)
  end
end
