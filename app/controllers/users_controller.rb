class UsersController < ApplicationController
    before_action :set_user 
    before_action :check_setup, except: [:setup, :update_profile, :update_character_selection, :update_name, :update_interests ]

    def profile
        @interests = Interest.all();
        @selected_interests = current_user.interests.pluck(:id);
        @jobs = Interest.where(isRole: true)
        @current_job= current_user.user_interests.where(isPrimaryRole: true).pluck(:interest_id)
        @equipmentHelmet = current_user.equipments.where(category: 0)
        @equipmentWeapon = current_user.equipments.where(category: 1)
        @equipmentChest = current_user.equipments.where(category: 2)
        @equipmentBottoms = current_user.equipments.where(category: 3)
        @equippedHelmet = current_user.equipments.where(category: "helmet").where(user_equipments: {equipped: true}).pluck(:id)[0]
        @equippedBottoms = current_user.equipments.where(category: "bottoms").where(user_equipments: {equipped: true}).pluck(:id)[0]
        @equippedChest = current_user.equipments.where(category: "chest").where(user_equipments: {equipped: true}).pluck(:id)[0]
        @equippedWeapon = current_user.equipments.where(category: "weapon").where(user_equipments: {equipped: true}).pluck(:id)[0]

        
    end

    def setup
        @interests = Interest.all();
        @jobs = Interest.where(isRole: true)

        #TO REMOVE
        @character_selection = CharacterSelection.where.not(url: "Character4alt.svg");
    end


    def set_user
        @user = current_user
    end

    def update_profile
        if(interest_params[:helmetSelect])
            update_all_equipment()
        end
        if (interest_params[:interests] && interest_params[:primary_role])
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
            equipmentList = current_user.equipments
            if equipmentList.count < 1 then
                beginnerEquipment = Equipment.where("name ILIKE ?", "%Beginner%")
                firstQuest = Pathway.where(name: "Registration").first()
                UserPathway.create([{user_id: current_user.id, pathway_id: firstQuest.id, progress:2}])
                beginnerEquipment.each do |equipment|
                    UserEquipment.create([{
                        user_id: current_user.id,
                        equipment_id: equipment.id
                    }])
                end
            end
            redirect_to setup_path
        end
    end

     # Only allow a list of trusted parameters through.
     def interest_params
        params.permit(:primary_role, :character_selection, :name, :helmetSelect, :bottomsSelect, :chestSelect, :weaponSelect, :interests => [])
    end

    def update_all_equipment 
        current_user.user_equipments.update_all(equipped: false)
        update_equipment(interest_params[:helmetSelect])
        update_equipment(interest_params[:bottomsSelect])
        update_equipment(interest_params[:chestSelect])
        update_equipment(interest_params[:weaponSelect])

        #TO REMOVE
        characterSelection = CharacterSelection.where(url: "Character4alt.svg").first();
        current_user.character_selection_id = characterSelection.id
        current_user.save


    end
    def update_equipment(id)
        current_user.user_equipments.where(equipment_id: id).update_all(equipped: true)
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
        current_user.save
    end

    def update_name

        current_user.name = interest_params[:name]
        current_user.save
    end

     
  
end
