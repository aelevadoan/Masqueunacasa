class AddOriginalLocaleToAllModelsWithTranslations < ActiveRecord::Migration
  def up
    [Proposal, Phase, Category, Experiencie].each do |klass|
      add_column klass.table_name, :original_locale, :string, limit: 4
    end

    [Proposal, Phase, Category, Experiencie].each do |klass|
      klass.all.each do |obj|
        obj.update_column :original_locale, "es"
      end
    end
  end

  def down
    [Proposal, Phase, Category, Experiencie].each do |klass|
      remove_column klass.table_name, :original_locale
    end
  end
end
