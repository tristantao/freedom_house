class AddContainsHateSpeechBooleanToArticle < ActiveRecord::Migration
  def up
    #false positives are preferred. Perhaps default to true if necessary.
    add_column :articles, :contains_hatespeech, :boolean
  end

  def down
    remove_column :articles, :contains_hatespeech
  end
end
