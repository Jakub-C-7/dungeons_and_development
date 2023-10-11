class UsersController < ApplicationController
    before_action :set_user 

    def profile

    end


    def set_user
        @user = current_user
    end
end
