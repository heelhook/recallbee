class CreateToyReports < ActiveRecord::Migration
  def change
    create_table :toy_reports do |t|
      t.references :toy, index: true
      t.string :source
      t.string :recall_number
      t.date :recall_date
      t.text :hazard
      t.text :remedy
      t.text :description
      t.text :sold_at
      t.string :remedy_types
      t.string :importer
      t.string :manufactured_in
      t.text :consumer_contact
      t.text :incidents_reported
      t.string :units_sold

      t.timestamps null: false
    end
    add_foreign_key :toy_reports, :toys
  end
end
