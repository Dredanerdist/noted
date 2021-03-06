class Note
  include MongoMapper::Document

  key :title, String
  key :body, String
  key :sources, Array
  key :permalink, String

  timestamps!
  userstamps!

  validates_uniqueness_of :permalink

  belongs_to :project

  after_create :permalink!

  def url
    "#{self.project.url}/notes/#{self.permalink}"
  end

  private

  def permalink!
    self.permalink = Base32::Crockford.encode(self.class.count + 1)
  end
end
