class KittensController < ApplicationController
  def index
    @kittens = Kitten.all

    respond_to do |format|
      format.html
      format.json { render :json => @kittens }
    end
  end

  def show
    @kitten = Kitten.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @kitten }
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new(params_required)

    if @kitten.save
      flash[:notice] = "Nice, you created a new kitten!"
      redirect_to @kitten
    else
      flash[:alert] = "Maybe you forgot to put something."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])

    if @kitten.update(params_required)
      flash[:notice] = "Great, you changed the kitten!"
      redirect_to @kitten
    else
      flash[:alert] = "Oops, you forgot something needed to change the kitten."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    @kitten.destroy

    flash[:notice] = "Excellent, you destroyed a kitten."
    redirect_to root_path, status: :see_other
  end

  private

  def params_required
    params.require(:kitten).permit(:name, :age, :cuteness, :softness)
  end
end
