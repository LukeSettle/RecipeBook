class RecipesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery

  before_action :find_recipe, only: [:edit, :update, :show]
  before_action :collect_tags, only: [:new, :edit]

  def index
    if params[:user_id]
      @user = User.find_by(id: params[:user_id])
      @recipes = @user.saved_and_stored_recipes
    else
      @recipes = Recipe.all
    end
    @recipes = @recipes.page(params[:page]).per(3)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    @recipe.image_text = ImageToTextService.new(@recipe.recipe_image).text_from_image

    @recipe.save
    redirect_to @recipe
  end

  def show
    @recipes = Recipe.all
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      redirect_to @recipe
    else
      render 'edit'
    end
  end

  def destroy
    if @recipe.destroy
      render 'index'
    else
      flash['warning'] = 'There was an error trying to delete this recipe'
      redirect_to @recipe
    end
  end

  private

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :recipe_image, tag_ids: []).merge(user_id: current_user.id)
  end

  def collect_tags
    @tags = Tag.all.collect { |tag| [ tag.title, tag.id ] }
  end
end