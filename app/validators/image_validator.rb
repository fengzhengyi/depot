# frozen_string_literal: true
class ImageValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    supported_extensions = options.fetch(:supported_extensions, %w{.gif .jpg .png .jpeg})
    if value.present? && !supported_extensions.include?(File.extname(value.downcase))
      record.errors.add(attribute, :invalid_image_extension, valid_extensions: supported_extensions)
    end
  end

  # 也可以
  # def validate_each(record, attribute, value)
  #   record.errors.add(attribute,(options[:message] || 'must be a URL for GIF, JPG or PNG image.')) unless value =~ /\.(gif|jpg|png)\z/i
  # end
  # 失败，问题出在record.errors[attribute] <<
  # def validate_each(record, attribute, value)
  #   record.errors[attribute] << (options[:message] || 'must be a URL for GIF, JPG or PNG image.') unless value =~ /\.(gif|jpg|png)\z/i
  # end
end
