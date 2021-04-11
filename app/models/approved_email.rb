# frozen_string_literal: true

class ApprovedEmail < ApplicationRecord
  require 'csv'
  validates :email, presence: true

  def self.import(file)
    return -3 if file.nil?
    return nil if File.extname(file) != '.csv'

    @counter = 0
    @header = nil
    @headers = CSV.open(file.path, &:first)
    @headers.each do |e|
      if /^(|e)mail$/.match?(e.downcase.delete('-'))
        @header = e
        break
      end
    end
    if !@header.nil?
      CSV.foreach(file.path, headers: true) do |row|
        @email = row[@header]

        unless @email.nil?
          @email_object = ApprovedEmail.find_by(email: @email)
          @existing_user = User.find_by(user_email: @email)
          if @email_object.nil? && @existing_user.nil?
            @approved_email = ApprovedEmail.new(email: @email)
            return -1 unless @approved_email.save

            @counter += 1
          elsif !@existing_user.nil?
            @existing_user_profile = UserProfile.where(user_id: @existing_user.id)
            if (@existing_user.approved_status == false) && @existing_user_profile.exists?
              @approved_email = ApprovedEmail.new(email: @email)
              return -1 unless @approved_email.save

              @counter += 1
            end
          end
        end
      end
      @counter
    else
      -2
    end
  end
end
