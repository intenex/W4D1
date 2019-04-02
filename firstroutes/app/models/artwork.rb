# == Schema Information
#
# Table name: artworks
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Artwork < ApplicationRecord
    validates :title, :image_url, :artist_id, presence: true
    validates :title, uniqueness: { scope: :artist_id, message: "no two same artworks per artist" }
    # within the scope of each :artist_id, make sure that all artwork titles are unique and there are no duplicates
    # multiple artists can have the same titled artwork, but no single artist can have two artworks with the same title

    belongs_to :artist, foreign_key: :artist_id, class_name: :User

    has_many :artwork_shares, class_name: :ArtworkShare, foreign_key: :artwork_id
    
    has_many :shared_viewers, through: :artwork_shares, source: :viewer

    has_many :comments
end
