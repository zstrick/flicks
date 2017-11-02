class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :characterizations, dependent: :destroy
  has_many :genres, through: :characterizations

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :released_on, :duration, presence: true
  validates :title, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, allow_blank: true, format: {
    with:    /\w+\.(gif|jpg|png)\z/i,
    message: "must reference a GIF, JPG, or PNG image"
  }
  validates :rating, inclusion: { in: RATINGS }

  before_validation :generate_slug

  scope :released, -> { where("released_on <= ?", Time.now).order(released_on: :desc) }
  scope :flops, -> { released.where("total_gross < ?", 50000000).order(total_gross: :desc) }
  scope :hits, -> { released.where("total_gross >= ?", 300000000).order(total_gross: :desc) }
  scope :recently_added, -> { order("created_at desc").limit(3) }
  scope :upcoming, -> { where("released_on > ?", Time.now).order(released_on: :asc) }
  scope :rated, ->(rating) { released.where(rating: rating) }
  scope :recent, ->(max=5) { released.limit(max) }

  def flop?
    total_gross.blank? || total_gross < 50000000
  end

  def average_stars
    reviews.average(:stars)
  end

  def to_param
    slug
  end

  def generate_slug
    self.slug ||= title.parameterize if title
  end
end
