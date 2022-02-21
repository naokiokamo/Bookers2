class BooksController < ApplicationController
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
     @user = current_user
     @books = Book.all
     @book = Book.new(book_params)
     @book.user_id = current_user.id
    if @book.save
     flash[:notice] = "Book was successfully created."
     redirect_to book_path(@book.id)
    else
     @books = Book.all
     render :index
    end
  end


  def show
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user != current_user
     redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
    flash[:notice] = "Book was successfully update."
    redirect_to book_path(@book.id)
   else
     @books = Book.all
     render :edit
   end
  end



  def destroy
    @book = Book.find(params[:id])
    if @book.destroy
     redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
