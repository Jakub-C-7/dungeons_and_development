class UsersController < ApplicationController
    before_action :set_user 
    before_action :check_setup, except: [:setup, :updateprofile]

    def profile

    end

    def setup
        @interests = Interest.all();
        @jobs = Interest.where(isRole: true)
    end


    def set_user
        @user = current_user
    end

    def updateprofile
        p "Updated"
    end

    

    def check_setup
        isSetup = UserInterest.where(user_id: current_user.id, isPrimaryRole: true).count
        if(isSetup ==0)
            redirect_to setup_path
        end
    end
end
