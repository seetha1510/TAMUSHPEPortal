# frozen_string_literal: true

class ApprovedEmail < ApplicationRecord
  require 'csv'
  validates :email, presence: true

  def self.import(file)
    if file == nil
      return -3
    end
    if File.extname(file) != ".csv"
      return nil
    end
    @counter = 0
    @header = nil
    @headers = CSV.open(file.path) { |csv| csv.first }
    @headers.each do |e|
      if e.downcase.gsub('-','')=~/^(|e)mail$/
        @header = e
        break
      end
    end
    if @header != nil
      CSV.foreach(file.path, headers: true) do |row|
        @email = row[@header]
        
        if !@email.nil?
          @email_object = ApprovedEmail.where(email: @email).first
          @existing_user = User.where(user_email:@email).first
          if @email_object.nil? and @existing_user.nil?
            @approved_email = ApprovedEmail.new(email: @email)
            if !@approved_email.save
              return -1
            end
            @counter += 1
          elsif !@existing_user.nil? 
            @existing_user_profile = UserProfile.where(user_id: @existing_user.id)
            if @existing_user.approved_status==false and @existing_user_profile.exists?
              @approved_email = ApprovedEmail.new(email: @email)
              if !@approved_email.save
                return -1
              end
              @counter += 1
            end
          end
        end
      end
      return @counter
    else
      return -2
    end
    
  end
end
