@students = []  # an empty array accessible to all methods

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

def process(selection)
  case selection
    when "1"
      input_students
    when "2"
      show_students
    when "3"
      save_students
    when "4"
      load_students
    when "9"
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
    @students << {name: name, cohort: cohort.to_sym}
    if @students.count == 1
      puts "Now we have #{@students.count} student"
    else
      puts "Now we have #{@students.count} students"
    end
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

def show_students
  if !@students.empty?
    print_header
    print_student_list
    print_footer
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

def print_footer
  if @students.count == 1
    puts "Overall, we have #{@students.count} great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each { |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  }
  file.close
end

<<<<<<< HEAD
def load_students(filename = "students.csv")
  file = File.open(filename, "r")
=======
def load_students
  file = File.open("students.csv", "r")
>>>>>>> fde56507e2e12aa04a236884469d7a683a5a57db
  file.readlines.each { |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  }
  file.close
end

<<<<<<< HEAD
def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quit the program
  end
end

try_load_students
=======
>>>>>>> fde56507e2e12aa04a236884469d7a683a5a57db
interactive_menu
