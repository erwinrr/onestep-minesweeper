class BoardsController < ApplicationController
  before_action :set_board, only: %i[ show edit update destroy ]

  # GET /boards or /boards.json
  def index
    @boards = Board.all
  end

  # GET /boards/1 or /boards/1.json
  def show
  end

  # GET /boards/new
  def new
    @board = Board.new
    @recent_boards = Board.all.order(created_at: :desc).limit(10)
  end

  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @recent_boards = Board.all.order(created_at: :desc).limit(10)
    @board = Board.new(board_params)
    respond_to do |format|      
      if @board.save
        @board.grid = Array.new(@board.height){ Array.new(@board.width) }
        # todo: use an array of integers possibilities then shuffle and pop off random numbers 
        # to prevent having to "guess correct" when the board starts filling up
        # mines = Array.new(@board.mine_count)
        # mines_added = 0 
        # until mines_added == mines.length
        #   mine = rand(0...@board.area)
        #   if mines.exclude? mine 
        #     mines[mines_added] = mine 
        #     mines_added += 1
        #   end   
        # end
        mines = []
        random_possibilities = (0...@board.area).to_a.shuffle
        @board.mine_count.times do 
          mine = random_possibilities.pop 
          mines.push(mine)
        end
        mines.each do |mine| 
          cordinates = mine.divmod(@board.width)
          x = cordinates[0]
          y = cordinates[1]
          @board.grid[x][y] = true
        end 
        @board.save
        format.html { redirect_to board_url(@board), notice: "Board was successfully created." }
        format.json { render :show, status: :created, location: @board }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to board_url(@board), notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy

    respond_to do |format|
      format.html { redirect_to boards_url, notice: "Board was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_board
      @board = Board.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def board_params
      params.require(:board).permit(:name, :email, :width, :height, :grid, :mine_count)
    end
end
