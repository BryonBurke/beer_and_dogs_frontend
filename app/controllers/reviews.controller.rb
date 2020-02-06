class ReviewsController < ApplicationController

  before_action only: [:edit, :update, :destroy] do
          authorize(:admin)
      end
      before_action only: [:new, :show] do
              authorize(:user)
          end
  def new
    id = params[:id]
    HTTParty.post("http://localhost:3000/establishments/#{id}/reviews", format: :plain)

    render :new
  end

  def create
    @establishment = Establishment.find(params[:establishment_id])
    @review = @establishment.reviews.new(review_params)
    if @review.save
      flash[:notice] = "Review successfully added!"
      redirect_to establishment_path(@establishment)
    else
      render :new
    end
  end

  # def show
  #   @product = Product.find(params[:product_id])
  #   @review = Review.find(params[:id])
  #   render :show
  # end
  #
  # def edit
  #   @product = Product.find(params[:product_id])
  #   @review = Review.find(params[:id])
  #   render :edit
  # end
  #
  # def update
  #   @review = Review.find(params[:id])
  #   if @review.update(review_params)
  #     redirect_to product_path(@review.product)
  #   else
  #     render :edit
  #   end
  # end
  #
  # def destroy
  #   @review = Review.find(params[:id])
  #   @review.destroy
  #   redirect_to product_path(@review.product)
  # end

  private
  def review_params
    params.require(:review).permit(:author, :content_body, :rating
  end
end
