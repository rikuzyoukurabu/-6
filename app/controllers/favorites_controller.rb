class FavoritesController < ApplicationController

  def create
  @favorite = current_user.favorites.create(book_id: params[:book_id])
  # <!--Ajax処理追加-->
  end

  def destroy
    @book = Book.find(params[:book_id])
    @favorite = current_user.favorites.find_by(book_id: @book.id)
    @favorite.destroy
    # <!--Ajax処理追加-->
  end
end
