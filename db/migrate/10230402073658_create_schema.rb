class CreateSchema < ActiveRecord::Migration[7.0]
  def change
    ActiveRecord::Base.connection.create_schema('dailydrill')
  end
end
