class BeersController < ApplicationController
  before_action :set_beer, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, except: [:index, :show, :list]

  # GET /beers
  # GET /beers.json
   def index
    @beers = Beer.all

    order = params[:order] || 'name'

    @beers = case order
      when 'name' then @beers.sort_by{ |b| b.name }
      when 'brewery' then @beers.sort_by{ |b| b.brewery.name }
      when 'style' then @beers.sort_by{ |b| b.style.name }
    end
  end

  # GET /beers/1
  # GET /beers/1.json
    def show
    @rating = Rating.new
    @rating.beer = @beer
  end

  def list
  end

  # GET /beers/new
   def new
   @beer = Beer.new
   @breweries = Brewery.all
   @styles = Style.all
 end

  # GET /beers/1/edit
  def edit
    @breweries = Brewery.all
    @styles = Style.all
  end

  # POST /beers
  # POST /beers.json
    

  # PATCH/PUT /beers/1
  # PATCH/PUT /beers/1.json
  def update
    respond_to do |format|
      if @beer.update(beer_params)
        format.html { redirect_to @beer, notice: 'Beer was successfully updated.' }
        format.json { render :show, status: :ok, location: @beer }
      else
        format.html { render :edit }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

    def create
    @beer = Beer.new(beer_params)

    respond_to do |format|
      if @beer.save
        format.html { redirect_to beers_path, notice: 'Beer was successfully created.' }
        format.json { render :show, status: :created, location: @beer }
      else
        @breweries = Brewery.all
        @styles = ["Weizen", "Lager", "Pale ale", "IPA", "Porter"]           
        format.html { redirect_to new_beer_path, notice: "Name can't be blank" }
        format.json { render json: @beer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beers/1
  # DELETE /beers/1.json
  def destroy
    respond_to do |format|
    #if current_user.is_admin
      @beer.destroy
      format.html { redirect_to beers_path, notice: 'Beer was successfully deleted.' }
      format.json { render :index }
    #else
      format.html { redirect_to beers_url, notice: 'You need to be admin to delete beer' }
      format.json { render :index }
    end
  #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beer
      @beer = Beer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beer_params
      params.require(:beer).permit(:name, :style, :brewery_id)
    end
end
