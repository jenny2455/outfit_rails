class ClothesController < ApplicationController
  before_action :set_clothe, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  # GET /clothes or /clothes.json
  def index
    @clothes = Clothe.all
  end

  # GET /clothes/1 or /clothes/1.json
  def show
  end

  # GET /clothes/new
  def new
    # @clothe = Clothe.new
    @clothe = current_user.clothes.build
  end

  # GET /clothes/1/edit
  def edit
  end



  # POST /clothes or /clothes.json
  def create
    # @clothe = Clothe.new(clothe_params)
    @clothe = current_user.clothes.build(clothe_params)

    respond_to do |format|
      if @clothe.save
        format.html { redirect_to clothe_url(@clothe), notice: "Clothe was successfully created." }
        format.json { render :show, status: :created, location: @clothe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /clothes/1 or /clothes/1.json
  def update
    respond_to do |format|
      if @clothe.update(clothe_params)
        format.html { redirect_to clothe_url(@clothe), notice: "Clothe was successfully updated." }
        format.json { render :show, status: :ok, location: @clothe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @clothe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clothes/1 or /clothes/1.json
  def destroy
    @clothe.destroy

    respond_to do |format|
      format.html { redirect_to clothes_url, notice: "Clothe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @clothe = current_user.clothes.find_by(id: params[:id])
    redirect_to clothes_path, notice: "Not authorized to edit this item" if @clothe.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_clothe
      @clothe = Clothe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def clothe_params
      params.require(:clothe).permit(:outfit_name, :weather, :outfit_type, :user_id)
    end
end
