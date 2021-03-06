class Source
  include MongoMapper::Document

  key :data, Hash
  key :markdown, String
  key :html, String
  key :permalink, String

  timestamps!
  userstamps!

  belongs_to :project

  after_save :cite!
  after_save :permalink!

  def url
    "#{self.project.url}/sources/#{self.permalink}"
  end

  private

  def cite!
  end

  def permalink!
    self.permalink = Base32::Crockford.encode(Source.count + 1)
  end
end