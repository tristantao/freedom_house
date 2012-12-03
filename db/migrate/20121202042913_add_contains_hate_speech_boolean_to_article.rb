class AddContainsHateSpeechBooleanToArticle < ActiveRecord::Migration
  def up
    #defaults to 1. If somehow classifier does not specify, false positives are preferred.
    add_column :articles, :contains_hatespeech, :boolean, :default => 1
  end

  def down
    remove_column :articles, :contains_hatespeech
  end
end
