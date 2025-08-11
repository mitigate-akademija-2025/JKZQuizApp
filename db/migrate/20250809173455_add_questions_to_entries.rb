class AddQuestionsToEntries < ActiveRecord::Migration[8.0]
  def change
    add_column :entries, :questions, :text
  end
end
