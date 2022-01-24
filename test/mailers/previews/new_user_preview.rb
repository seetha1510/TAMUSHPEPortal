class UserMailerPreview < ActionMailer::Preview
    def new_user_email
      UserMailer.with(user: User.where(user_email: "jonathan09@tamu.edu")[0]).new_user_email
    end
  end