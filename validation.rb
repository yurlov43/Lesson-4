module Validation
  def self.included(base)
    base.include InstanceMethods
    base.extend ClassMethods
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def validate!
      errors_clear
      self.class.attributes.each do |attribute|
        validation = self.class.send(
          attribute[:method_name],
          self.send(attribute[:attribute_name]),
          attribute[:parameter])
        errors << "#{attribute[:attribute_name]}: #{validation}" unless validation.nil?
      end
      raise errors.join("\n") unless errors.empty?
    end

    def errors
      @errors.nil? ? @errors = [] : @errors
    end

    def errors_clear
        @errors = []
    end
  end

  module ClassMethods
    def validate(attribute_name, validation_type, *parameter)
      attributes << {
        attribute_name: attribute_name,
        method_name: validation_type,
        parameter: parameter.first
      }
    end

    def attributes
      @attributes.nil? ? @attributes = [] : @attributes
    end

    def presence(attribute_value, parameter)
      if attribute_value.nil? || attribute_value == ''
        "attribute name not specified"
      end
    end

    def format(attribute_value, parameter)
      if !parameter.nil? && attribute_value.to_s !~ parameter
        "invalid attribute value"
      end
    end

    def type(attribute_value, parameter)
      unless attribute_value.instance_of?(parameter)
        "the attribute value does not match the specified class"
      end
    end
  end
end