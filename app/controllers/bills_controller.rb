class BillsController < ApplicationController
  before_action :set_bill, only: [:show, :edit, :update, :destroy]

  helper_method :get_friends_array
  helper_method :get_individual_total
  helper_method :get_grand_total

  # GET /bills
  # GET /bills.json
  def index
    @bills = Bill.all
  end

  # GET /bills/1
  # GET /bills/1.json
  def show
  end

  # GET /bills/new
  def new
    @bill = Bill.new
  end

  # GET /bills/1/edit
  def edit
  end

  # POST /bills
  # POST /bills.json
  def create
    @bill = Bill.new(bill_params)

    respond_to do |format|
      if @bill.save
        format.html { redirect_to @bill, notice: 'Bill was successfully created.' }
        format.json { render :show, status: :created, location: @bill }
      else
        format.html { render :new }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bills/1
  # PATCH/PUT /bills/1.json
  def update
    respond_to do |format|
      if @bill.update(bill_params)
        format.html { redirect_to @bill, notice: 'Bill was successfully updated.' }
        format.json { render :show, status: :ok, location: @bill }
      else
        format.html { render :edit }
        format.json { render json: @bill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.json
  def destroy
    @bill.destroy
    respond_to do |format|
      format.html { redirect_to bills_url, notice: 'Bill was successfully destroyed.' }
      format.json { head :no_content }
    end
  end



  # NON CRUD METHOD

  # returns an array that includes all the Friends who splitted a particular bills
  def get_friends_array

    friends_array = Array.new

    bill = Bill.find(params[:id])
    friends = @bill.friends

    (0...friends.length).each do |index|
      friends_array << friends[index]["name"]
    end
    friends_array

  end

  # return the INDIVIDUAL amount of dollars and cents per person. 
  def get_individual_total

    friends_array = Array.new

    bill = Bill.find(params[:id])
    transactions = @bill.transactions

    totals = Hash.new { |hash, key| hash[key] = { dollar: 0, cent: 0 } }
    transactions.each do |t|

      totals[t.payer][:dollar] += t.dollar
      totals[t.payer][:cent] += t.cent

      if totals[t.payer][:cent] >= 100
        totals[t.payer][:dollar] += totals[t.payer][:cent] / 100
        totals[t.payer][:cent] = totals[t.payer][:cent] % 100
      end

    end

    totals
  end

  # return the total amount of dollars and cents in this bill
  def get_grand_total
    friends_array = Array.new

    bill = Bill.find(params[:id])
    transactions = @bill.transactions
    total_dollar = transactions.inject(0) { |sum, t| sum + t.dollar }
    total_cent = transactions.inject(0) { |sum, t| sum + t.cent }

    [total_dollar, total_cent]
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bill
      @bill = Bill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bill_params
      params.require(:bill).permit(:event_name, :urlID)
    end
end
