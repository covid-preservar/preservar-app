class CreatePlacesFromSeller < ActiveRecord::Migration[6.0]
  def up
    execute('CREATE TABLE places AS SELECT * FROM sellers')
    execute('CREATE SEQUENCE places_id_seq;')
    execute("ALTER TABLE ONLY places ALTER COLUMN id SET DEFAULT nextval('places_id_seq')")
    execute("ALTER SEQUENCE places_id_seq OWNED BY places.id")
    execute("ALTER TABLE places ADD CONSTRAINT places_pkey PRIMARY KEY (id)")

    add_reference :places, :seller
    add_index :places, :slug, unique: true
    execute('UPDATE places set seller_id = id')

    rename_column :vouchers, :seller_id, :place_id

    remove_column :places, :payment_api_key
    remove_column :places, :vat_id
    remove_column :places, :contact_name
    remove_column :places, :company_name
    remove_column :places, :seller_user_id
  end

  def down
    drop_table :places
    rename_column :vouchers, :place_id, :seller_id
  end
end
