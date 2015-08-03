class FriendsController < ApplicationController

	def create

		@bill = Bill.find(params[:bill_id])
		@friend = @bill.friends.build(friend_params)
		if @friend.save
			redirect_to bill_path(@bill)
		else
			flash[:error] = "Something went wrong, please check and re-enter your fields again!"
			redirect_to bill_path(@bill)
		end
	end

	def destroy
		@bill = Bill.find(params[:bill_id])
		@friend = @bill.friends.find(params[:id])
		@friend.destroy
		redirect_to bill_path(@bill)
	end

	private

	def friend_params
		params.require(:friend).permit(:name)
	end
end
