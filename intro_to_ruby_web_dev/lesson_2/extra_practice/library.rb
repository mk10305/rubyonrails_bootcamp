
#Questions. Difference between module and use of subclasses
#Distinct Method
#Reject Method
#Sort by Author
#Sort by Title



module Book
  def pretty_output
    "#{name} by #{author}"
  end

  def to_s
    pretty_output
  end

end



class Library_Book
  include Book
  attr_accessor :name, :author
  def initialize (n, a)
    @name = n
    @author = a
  end
end



class User_Book
  include Book
  attr_accessor :name, :author
  def initialize ()
    puts "You want to add a book to the library."
    puts "Enter the name of the book"
    @name = gets.chomp
    puts "Now please enter the author of this book"
    @author = gets.chomp
  end
end

class Library
  attr_accessor :books, :user_input
  def initialize
    puts "====> Welcome to the Library! <===="
    @books = []
    @user_input = user_input
    create_library
  end

  def prompt
    begin
      user_input_choices = ['1', '2', '3', '4']
      puts "Enter:
      1) If you want to add a book to the library's collection
      2) If you want to see all the books in the library
      3) If you want to search for a book by author
      4) If you want to exit this app"
      user_input = gets.chomp
      if user_input == "1"
        puts "Let's add a book to the library's collection"
        #Creating a Book object will trigger add book dialogue 
        new_book = User_Book.new()
        add_library(new_book)
        prompt
      
      elsif user_input == "2"
        puts "Here are all the books in the library...."
        show_books
        prompt

      elsif user_input == "3"
        puts "You want to search by author..."
        puts "Enter the author's full name to find books by that author"
        author_name = gets.chomp
        search_book(author_name)
        prompt
      elsif user_input == "4"
        exit
      end #end if/else
  end until user_input_choices.include?(user_input) 

  end

  def create_library
    existing_collection = [Library_Book.new("To Kill a Mockingbird", "Harper Lee"),Library_Book.new("Lord of the Flies", "William Golding"),Library_Book.new("Of Mice and Men", "John Steinbeck"),Library_Book.new("The Great Gatsby", "F. Scott Fitzgerald")  ]
    existing_collection.each do |book|
      add_library(book)
    end 
  end

  def add_library(book)
    books.push(book)
  end

  def search_book(author)
    results = books.select {|book| book.author == author}
    if !results.empty?
      results.each do |result|
        puts "#{result}"
      end
    else puts "No books were found by #{author}"
    end
  end

  def show_books

    books.each do |book|
      puts "#{book}"
    end 
  end

  
end #end Book class



collection = Library.new
collection.prompt