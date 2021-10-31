require 'resolv'

class BlacklistedDomainValidator < ActiveModel::EachValidator
  DOMAIN_BLACKLIST = [
    Resolv::IPv4::Regex,
    'localhost',
    '4ny.us'
  ]

  def validate_each(record, attribute, value)
    return unless value.present?

    hostname = URI.parse(value).hostname
    return unless hostname

    DOMAIN_BLACKLIST.each do |blacklist|
      return record.errors.add(attribute, "#{hostname} is forbidden") if blacklist.match?(hostname)
    end
  end
end
