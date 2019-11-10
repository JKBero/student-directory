@students = []  # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to a file of your choice"
  puts "4. Load the list from a file of your choice"
  puts "5. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      filename = request_filename
      save_students(filename)
    when "4"
      filename = request_filename
      load_students(filename)
    when "5"
      exit # this will cause the program to terminate
    else
      puts "I don't know what you meant, try again"
  end
end

def input_students
  puts "Please enter the names of the students and the month of their cohort"
  puts "To finish, just hit return twice"
  puts "Name of student:"
  name = STDIN.gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # get the cohort
    cohort = cohort_selection
    if cohort == false then redo end
    update_student_list(name, cohort)
    print_student_count
    # get another name from the user
    puts "Name of student:"
    name = STDIN.gets.chomp
  end
end

def cohort_selection
  puts "Cohort of student:"
  cohort = STDIN.gets.chomp.capitalize
  # if an invalid month/typo entered, it returns false
  require 'date'
  if !Date::MONTHNAMES.include?(cohort)
    puts "Invalid month given"
    false
  else cohort
  end
end

def update_student_list(name, cohort)
  @students << {name: name, cohort: cohort.to_sym}
end

def show_students
  if !@students.empty?
    print_header
    print_student_list
    print_student_count
  else
    puts "The student list is empty"
  end
end

def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_student_list
  @students.each { |student|
    puts "#{student[:name]} (#{student[:cohort]} cohort)"
  }
end

def print_student_count
  if @students.count == 1
    puts "Overall, we have #{@students.count} student"
  else
    puts "Overall, we have #{@students.count} students"
  end
end

def request_filename
  puts "Please enter the filename"
  STDIN.gets.chomp
end

def save_students(filename)
  # open the file for writing
  if File.exists?(filename)
    File.open(filename, "w") { |f|
      # iterate over the array of students
      @students.each { |student|
        student_data = [student[:name], student[:cohort]]
        csv_line = student_data.join(",")
        f.puts csv_line
      }
    }
    puts "Data successfully saved"
  else
    puts "Sorry, file doesn't exist."
  end
end

def load_students(filename)
  # open the file for reading
  if File.exists?(filename)
    File.open(filename, "r") { |f|
      f.readlines.each { |line|
        name, cohort = line.chomp.split(",")
        update_student_list(name, cohort)
      }
    }
    puts "Data successfully loaded"
  else
    puts "Sorry, file doesn't exist."
  end
end

def load_students_on_startup # if a file is provided by user
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

=begin

def save_students(filename)
  # open the file for writing
  if File.exists?(filename)
    File.open(filename, "w") { |f|
      # iterate over the array of students
      @students.each { |student|
        student_data = [student[:name], student[:cohort]]
        csv_line = student_data.join(",")
        f.puts csv_line
      }
    }
    puts "Data successfully saved"
  else
    puts "Sorry, file doesn't exist."
  end
end

def load_students(filename)
  # open the file for reading
  if File.exists?(filename)
    File.open(filename, "r") { |f|
      f.readlines.each { |line|
        name, cohort = line.chomp.split(",")
        update_student_list(name, cohort)
      }
    }
    puts "Data successfully loaded"
  else
    puts "Sorry, file doesn't exist."
  end
end

def load_students_on_startup # if a file is provided by user
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} students from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

=end

load_students_on_startup
interactive_menu
