class AddStyleReferenceToBeers < ActiveRecord::Migration[7.0]
  def change
    add_reference :beers, :style, null: false, foreign_key: true
  end
end
