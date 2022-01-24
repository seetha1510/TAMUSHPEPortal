class UserMailer < ApplicationMailer
    def new_user_email
        @user = params[:user]
        @cur_user_profile = UserProfile.find_by(user_id: @user)
        @profile_picture_name = 'default' + (@cur_user_profile.user_id % 6 + 1).to_s + ".png"

        attachments.inline["tamuSHPE_app_logo.png"] = File.read("#{Rails.root}/app/assets/images/tamuSHPE_app_logo.png")
        
        if !(@cur_user_profile.user_profile_picture.attached? && @cur_user_profile.user_profile_picture.representable?)
          attachments.inline[@profile_picture_name] = File.read("#{Rails.root}/app/assets/images/" + @profile_picture_name)
        else
          attachments.inline[@cur_user_profile.user_profile_picture.filename.to_s] = @cur_user_profile.user_profile_picture.download
        end


        mail(to: ENV["TAMUSHPE_GMAIL_USERNAME"], subject: "MemberSHPE Portal: New User Request!")
      end
end
