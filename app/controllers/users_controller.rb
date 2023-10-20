class UsersController < ApplicationController
    before_action :set_user 
    before_action :check_setup, except: [:setup, :update_profile]

    def profile
        @interests = Interest.all();
        @selected_interests = current_user.interests.pluck(:id);
        @jobs = Interest.where(isRole: true)
        @current_job= current_user.user_interests.where(isPrimaryRole: true).pluck(:interest_id)
        p "Hello"
        p @current_job

        
    end

    def setup
        @interests = Interest.all();
        @jobs = Interest.where(isRole: true)
        @character_selection = CharacterSelection.all();
    end


    def set_user
        @user = current_user
    end

    def update_profile
        p interest_params
        if (interest_params[:interests] && interest_params[:primary_role])
            p interest_params[:primary_role]
            update_interests()
        end
        if (interest_params[:character_selection])
            update_character_selection()
        end
        if (interest_params[:name])
            update_name()
        end

        redirect_to root_path
                

        
    end

    

    def check_setup
        isSetup = UserInterest.where(user_id: current_user.id, isPrimaryRole: true).count
        if(isSetup ==0)
            redirect_to setup_path
        end
    end

     # Only allow a list of trusted parameters through.
     def interest_params
        params.permit(:primary_role, :character_selection, :name, :interests => [])
    end


    def update_interests
        p "Updating interests"
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
        end
    end

    def update_character_selection
        current_user.character_selection_id = interest_params[:character_selection]
    end

    def update_name
        current_user.name = interest_params[:name]
    end

     
  
end
