class AddClassSurvey < ActiveRecord::Migration
  def change
    create_table(:surveys) do |s|
      s.column(:name, :string)
    end
  end
end
