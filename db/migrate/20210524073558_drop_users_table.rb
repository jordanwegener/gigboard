class DropUsersTable < ActiveRecord::Migration[6.1]
  def up
    execute "DROP TABLE #{:users} CASCADE"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
