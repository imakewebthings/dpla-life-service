class ReviewsController < ApplicationController
  before_filter :auth_and_get_user, only: [:create, :update, :destroy]
  before_filter :get_review, only: [:show, :update, :destroy]

  def index
    @reviews = Review.where(book_id: params[:book_id])
  end

  def show
  end

  def create
    params[:review][:book_id] = params[:book_id]
    @review = @user.reviews.create! params[:review]
    render :show, status: 201
  end

  def update
    if @review.user == @user
      @review.update_attributes! params[:review]
      render :show
    else 
      head 401
    end
  end

  def destroy
    if @review.user == @user
      @review.destroy
      head 204
    else 
      head 401
    end
  end

  private
    def get_review
      @review = Review.find params[:id]
    end
end