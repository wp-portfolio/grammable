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
    aGram
    return render_not_found if aGram.blank?
  end

  def edit
    aGram
    return render_not_found if aGram.blank?
  end

  def index
  end

  def destroy
    aGram
    return render_not_found if aGram.blank?
    aGram.destroy
    redirect_to root_path
  end

  def update
    aGram
    return render_not_found if aGram.blank?
    aGram.update_attributes(gram_params)
    if @gram.valid?
      redirect_to root_path
    else
      return render :edit, status: :unprocessable_entity
    end
  end

  private
  def render_not_found
      render plain: 'Not Found', status: :not_found
  end

  def aGram
    @gram = Gram.find_by_id(params[:id])
  end

  def gram_params
    params.require(:gram).permit(:message)
  end

end
