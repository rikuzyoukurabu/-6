class SearchesController < ApplicationController
  before_action :authenticate_user!
  # log inしてるuserしか出来ない

  def search
    @range = params[:range]
    # モデルを選択してそれを取ってきてる

    if @range == "User"
      @users = User.looks(params[:search],params[:word])
      # usermodel内の検索結果を代入する
    else
      # 検索Bookmodel
      @books = Book.looks(params[:search],params[:word])
      # Bookmodel内の検索結果を代入する
    end
  end
end
