class StylesController < ApplicationController
  before_action :set_style, only: %i[ show edit update destroy ]

  # GET /styles or /styles.json
  def index
    @styles = Style.all
  end

  # GET /styles/1 or /styles/1.json
  def show
  end

  # GET /styles/new
  def new
    @style = Style.new
  end

  # GET /styles/1/edit
  def edit
  end

  # POST /styles or /styles.json
  def create
    @style = Style.new(style_params)

    respond_to do |format|
      if @style.save
        format.html { redirect_to @style, notice: "Style was successfully created." }
        format.json { render :show, status: :created, location: @style }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /styles/1 or /styles/1.json
  def update
    respond_to do |format|
      if @style.update(style_params)
        format.html { redirect_to @style, notice: "Style was successfully updated." }
        format.json { render :show, status: :ok, location: @style }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /styles/1 or /styles/1.json
  def destroy
    @style.destroy

    respond_to do |format|
      format.html { redirect_to styles_path, status: :see_other, notice: "Style was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @style = Style.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def style_params
      params.require(:style).permit(:name, :type)
    end
end
