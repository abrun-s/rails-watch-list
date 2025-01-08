class ListsController < ApplicationController

  def show
    @list = List.find(params[:id])

  end

  def index
    @lists = List.all
  end

  def create
    @list = List.new(list_params)
    # debugger
    if @list.save
      redirect_to list_path(@list)
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def new
    @list = List.new
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end
end
