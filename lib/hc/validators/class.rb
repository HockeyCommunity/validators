# frozen_string_literal: true

require 'active_model'

module HC
  module Validators
    # Allows for ActiveRecord validation of class types
    #
    class ClassValidator < ActiveModel::EachValidator
      def validate_each(record, attribute = nil, value = nil)
        options = default_options.merge(self.options)
        if options[:is_a]
          validate_one(options, record, attribute, value)
        elsif options[:in]
          validate_in(options, record, attribute, value)
        elsif options[:array_of]
          validate_array(options, record, attribute, value)
        else
          raise 'Invalid validation options'
        end
      end

      def error(record, attribute)
        record.errors.add(attribute, options[:message] || generate_message)
      end

      def generate_message
        if options[:is_a]
          "must be a #{options[:is_a]}"
        elsif options[:in]
          "must be one of: #{options[:in]}"
        elsif options[:array_of]
          "must be an array of #{options[:array_of]}"
        else
          :invalid
        end
      end

      private

      def default_options
        { is_a: nil, in: nil, array_of: nil, size: nil, cast: nil }
      end

      def validate_one(options, record, attribute, value)
        error(record, attribute) unless value.is_a?(options[:is_a])
      end

      def validate_in(options, record, attribute, value)
        passed = false
        options[:in].each do |klass|
          passed = true if value.is_a?(klass)
        end
        error(record, attribute) unless passed
      end

      def validate_array(options, record, attribute, value)
        unless value.is_a?(Array)
          error(record, attribute)
          return
        end

        if options[:size].to_i.positive?
          unless value.count == options[:size]
            error(record, attribute)
            return
          end
        end

        passed = true
        value.each do |item|
          passed = false unless item.is_a?(options[:array_of])
        end
        error(record, attribute) unless passed
      end
    end
  end
end
