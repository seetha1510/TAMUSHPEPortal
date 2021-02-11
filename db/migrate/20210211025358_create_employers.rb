class CreateEmployers < ActiveRecord::Migration[6.1]
  def change
    create_table :employers, id: false do |t|

      #create primary key
      t.integer :employer_id, primary_key: true, index: true, unique: true, null: false
      t.string :employer_description
      t.string :employer_industry
      t.string :employer_website_url

      t.timestamps
    end
  end
end