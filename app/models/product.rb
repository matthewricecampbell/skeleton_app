require 'csv'
class Product < ActiveRecord::Base
  cattr_accessor :current_user
  belongs_to :user

    def self.import(file)
      CSV.foreach(file.path, headers: false) do |row|
        record = Product.where(
        name: row[0],
        description: row[1],
        price: row[2],
        user_id: current_user.id
      ).first_or_create
    end
  end

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      all
    end
  end
end
