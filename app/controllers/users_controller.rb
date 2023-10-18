class UsersController < ApplicationController
    before_action :set_user 
    before_action :check_setup, except: [:setup, :update_interests]

    def profile

    end

    def setup
        @interests = Interest.all();
        @jobs = Interest.where(isRole: true)
    end


    def set_user
        @user = current_user
    end

    def update_interests
        if UserInterest.destroy_by(user_id: current_user.id)

        #Doesn't work and I want to understand why - probably a race condition
        # UserInterest.where(["user_id = ? and interest_id NOT IN (?)", current_user.id, interest_params[:interests]]).destroy_all
        # UserInterest.where(user_id: current_user.id, isPrimaryRole: true).destroy_all

            @user_interest  = UserInterest.new(user_id: current_user.id, interest_id: interest_params[:primary_role], isPrimaryRole: true)
            begin
                @user_interest.save
            rescue => error
                p error
            end
            
            interest_params[:interests].each  do|interest|
                p interest
                @user_interest  = UserInterest.new(user_id: current_user.id, interest_id: interest, isPrimaryRole: false)
                begin
                    @user_interest.save
                rescue => error
                    p error 
                end
            end
            redirect_to root_path
        end
        
    end

    

    def check_setup
        isSetup = UserInterest.where(user_id: current_user.id, isPrimaryRole: true).count
        if(isSetup ==0)
            redirect_to setup_path
        end
    end

     # Only allow a list of trusted parameters through.
     def interest_params
        params.permit(:primary_role, :interests => [])
    end


     
  
end
