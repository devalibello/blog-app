class ChangeDefaultForPostCounter < ActiveRecord::Migration[7.1]
  def change
    change_column_default :users, :postcounter, 0
  end
end
