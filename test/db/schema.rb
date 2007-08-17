ActiveRecord::Schema.define(:version => 0) do
  create_table :preferences, :force => true do |t|
    t.column :some_count, :integer
    t.column :show_help, :boolean, :default => true
  end

  create_table :people, :force => true do |t|
    t.column :first_name, :string
    t.column :last_name,  :string
  end
end
