class Shortener::Link < ApplicationRecord
  # some browsers would accept > 64k chars, but many won't (edge, android, i.e)
  MAX_LONG_URL_LENGTH = 2048
  DEFAULT_PROTOCOL = 'http'

  before_save :generate_token!, unless: :token?

  validates :token, uniqueness: true

  # cover only the basic cases of invalid urls
  validates :long_url, format: { with: URI.regexp },
                       blacklisted_domain: true,
                       presence: true,
                       length: { maximum: MAX_LONG_URL_LENGTH }

  has_many :visitors, class_name: 'Shortener::LinkVisitor', foreign_key: :shortener_link_id

  def short_url
    Rails.application.routes.url_helpers.shortener_link_url(token) if token.present?
  end

  private

  def generate_token!
    self.token = Shortener::TokenGenerator.generate do |new_token|
      !self.class.exists?(token: new_token)
    end
  end
end
