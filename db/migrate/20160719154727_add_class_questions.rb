class AddClassQuestions < ActiveRecord::Migration
  def change
    create_table(:questions) do |q|
      q.column(:name, :string)
      q.column(:answer, :string)
      q.column(:done, :boolean)
    end
  end
end
