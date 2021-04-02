# frozen_string_literal: true

class ApprovedEmail < ApplicationRecord
  require 'csv'
  validates :email, presence: true

  def self.import(file)
    # if MIME::Types.type_for(@file).first.content_type != 'text/csv'
    #   return nil
    # end
    if File.extname(file) != ".csv"
      return nil
    end
    @counter = 0
    @header = nil
    @headers = CSV.open(file.path) { |csv| csv.first }
    @headers.each { |e| @header = e if e.downcase.gsub('-','')=~/^(|e)mail$/ }
    if @header != nil
      CSV.foreach(file.path, headers: true) do |row|
        @email = row[@header]
        
        if !@email.nil?
          @email_object = ApprovedEmail.where(email: @email).first
          if @email_object.nil?
            @approved_email = ApprovedEmail.new(email: @email)
            if !@approved_email.save
              return -1
            end
            @counter += 1
          end
        end
      end

      return @counter
    end
  end
end
