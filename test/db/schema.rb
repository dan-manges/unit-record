ActiveRecord::Schema.define do
  create_table :preferences, force: true do |t|
    t.column :some_count, :integer
    t.column :show_help, :boolean, default: true
  end

  create_table :people, force: true do |t|
    t.column :first_name, :string
    t.column :last_name,  :string
  end

  create_table 'profiles', force: true do |t|
    t.column 'description', :string
    t.column 'person_id', :integer
  end

  create_table :pets, force: true do |t|
    t.column :name, :string
  end

  create_table :foofoo, force: true do |t|
    t.column :bar, :string
  end

  add_index 'people', ['first_name']
end
