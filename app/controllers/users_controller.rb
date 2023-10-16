class UsersController < ApplicationController
    before_action :set_user 
    before_action :check_setup, except: [:setup]

    def profile

    end

    def setup
        @interests = Interest.all();
        p @interests
    end


    def set_user
        @user = current_user
    end

    

    def check_setup
        isSetup = UserInterest.where(user_id: current_user.id, isPrimaryRole: true).count
        if(isSetup ==0)
            redirect_to setup_path
        end
    end
end
