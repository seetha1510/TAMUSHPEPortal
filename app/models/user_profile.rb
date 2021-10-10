# frozen_string_literal: true

class UserProfile < ApplicationRecord
  validates :user_id, presence: true
  validates :user_facebook_profile_url,
            format: { with: /\A.*facebook.com.*\z/, message: 'Use a Valid Facebook URL' }, allow_blank: true
  validates :user_instagram_profile_url,
            format: { with: /\A.*instagram.com.*\z/, message: 'Use a Valid Instagram URL' }, allow_blank: true
  validates :user_linkedin_profile_url,
            format: { with: /\A.*linkedin.com.*\z/, message: 'Use a Valid Linkedin URL' }, allow_blank: true
  validates :user_graduating_year,
            format: { with: /\A[0-9]{4}\z/, message: 'Enter 4 Digit Year' }, presence: { message: 'Enter Your Graduation Year' }
  validates :user_phone_number,
            format: { with: /\A(\+1)?[0-9]{10}\z/, message: 'Use a Valid Phone Number' }, allow_blank: true
  validates :user_about_me_description,
            format: { with: /\A(.){0,200}\z/, message: 'About Me should be less than 200 characters' }, allow_blank: true
  validates :user_first_name, presence: { message: 'Enter Your First Name' },
                              allow_blank: false
  validates :user_last_name, presence: { message: 'Enter Your Last Name' }, allow_blank: false
  validates :user_industry, presence: false, allow_blank: true
  belongs_to :user
  has_many :employees
  has_many :employers, through: :employees
  has_many :students
  has_many :schools, through: :students
  has_many :members
  has_many :committees, through: :members

  # Profile Picture
  has_one_attached :user_profile_picture, dependent: :destroy
  validates :user_profile_picture, content_type: %i[png jpg jpeg]

  before_save :make_lower_case, :add_url, :sanitize_profile_picture_name

  protected

  def make_lower_case
    user_first_name.downcase!
    user_last_name.downcase!
  end

  def add_url
    if user_facebook_profile_url.present? && !(user_facebook_profile_url[%r{^http://}] || user_facebook_profile_url[%r{^https://}])
      self.user_facebook_profile_url = "https://#{user_facebook_profile_url}"
    end

    if user_instagram_profile_url.present? && !(user_instagram_profile_url[%r{^http://}] || user_instagram_profile_url[%r{^https://}])
      self.user_instagram_profile_url = "https://#{user_instagram_profile_url}"
    end

    if user_linkedin_profile_url.present? && !(user_linkedin_profile_url[%r{^http://}] || user_linkedin_profile_url[%r{^https://}])
      self.user_linkedin_profile_url = "https://#{user_linkedin_profile_url}"
    end

    if user_portfolio_url.present? && !(user_portfolio_url[%r{^http://}] || user_portfolio_url[%r{^https://}])
      self.user_portfolio_url = "https://#{user_portfolio_url}"
    end
  end

  def sanitize_profile_picture_name
    if self.user_profile_picture.attached?
        ext = '.' + self.user_profile_picture.blob.filename.extension
        filename = ''
        if filename = self.user_profile_picture.blob.filename.base.gsub!(/[\\(\\)]/, '')
          filename = self.user_profile_picture.blob.filename.base.gsub!(/[\\(\\)]/, '') + ext
        else
          filename = self.user_profile_picture.blob.filename
        end
        self.user_profile_picture.blob.update(filename: filename)
    end
  end
end
