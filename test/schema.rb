ActiveRecord::Schema.define(:version => 0) do
  create_table :people do |t|
    t.column :first_name, :string
    t.column :last_name,  :string
  end
end
