class GramsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  
  def new
    @gram = Gram.new
  end

  def create
    @gram = current_user.grams.create(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  def show
    @gram = Gram.find_by_id(params[:id]) #find by id or return nil
    if @gram.blank?
      render plain: 'Not Found', status: :not_found
    end
  end

  def index
  end

  private

  def gram_params
    params.require(:gram).permit(:message)
  end

end
