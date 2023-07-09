class LinkBeersToStyles < ActiveRecord::Migration[7.0]
  def up
    Beer.all.each do |beer|
      style = Style.find_by(name: beer.old_style)
      beer.style = style
      beer.save
    end
  end

  def down
    Beer.all.each do |beer|
      beer.update(old_style: beer.style.name)
    end
  end
end
