





class Book
  attr_accessor :name, :author
  def initialize
    #ADD A BOOK IN INITIALIZE
    @name = name
    @author = author
    puts "You want to add a book to the library. That is Great!"
    puts "Enter the name of the book"
    name = gets.chomp
    puts "Now please enter the author of this book"
    author = gets.chomp
    puts "#{name} by #{author}"
  end

  def pretty_output
    "#{name} by #{author}"
  end

  def to_s
    pretty_output
  end

end

class Library
  attr_accessor :books, :user_input
  def initialize
    @books = []
    @user_input = user_input
    puts "Welcome to the Library!"
    puts "Enter 1) if you want to see all the books in the library. 2) Search for a book by Author 3) Add a Book to the library's collection"
    user_input = gets.chomp
    if user_input == "1"
      puts "Here are all the books in the library...."
    elsif user_input == "2"
      puts "You want to search by author..."
    else user_input == "3"
      puts "Let's add a book to the library's collection"
      #Creating a Book object will trigger add book dialogue 
      new_book = Book.new
      add_library(new_book)
      show_books

    end #end if/else
  end

  def add_library(book)
    books.push(book)
  end

  def show_books
    books.each do |book|
      puts "#{book}"
    end
  end

  
end #end Book class



collection = Library.new
