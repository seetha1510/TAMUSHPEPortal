class ApprovedPreview < ActionMailer::Preview
    def approved_email
        ApprovedMailer.with(user: User.where(user_email: "jonathan09@tamu.edu")[0]).approved_email
    end
  end