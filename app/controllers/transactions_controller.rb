class TransactionsController < ApplicationController

	def create
		@bill = Bill.find(params[:bill_id])
		@transaction = @bill.transactions.build(transaction_params)
		if @transaction.save
			redirect_to bill_path(@bill)
		else
			flash[:error] = "Something went wrong, please check and re-enter your fields again!"
			redirect_to bill_path(@bill)
		end
	end

	def destroy
		@bill = Bill.find(params[:bill_id])
		@transaction = @bill.transactions.find(params[:id])
		@transaction.destroy
		redirect_to bill_path(@bill)
	end

	private

	def transaction_params
		params.require(:transaction).permit(:payer, :dollar, :cent)
	end

end
