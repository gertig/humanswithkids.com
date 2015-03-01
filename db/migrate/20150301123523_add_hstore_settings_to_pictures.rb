class AddHstoreSettingsToPictures < ActiveRecord::Migration
  def change
    # https://devcenter.heroku.com/articles/heroku-postgres-extensions-postgis-full-text-search
    execute 'CREATE EXTENSION hstore'
    add_column :pictures, :settings, :hstore
  end
end
