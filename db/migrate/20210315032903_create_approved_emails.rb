class CreateApprovedEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :approved_emails do |t|

      t.string :email

      t.timestamps
    end
  end
end
