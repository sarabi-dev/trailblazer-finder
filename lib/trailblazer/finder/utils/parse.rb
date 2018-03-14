require 'date'

module Trailblazer
  class Finder
    # Helper module
    module Utils
      class Parse
        # Need a replacement for this
        def self.date(value)
          return unless valid_date(value)
          Date.parse(value).strftime('%Y-%m-%d')
        rescue ArgumentError
          nil
        end

        def self.valid_date(d)
          date_hash = Date._parse(d.to_s)
          Date.valid_date?(date_hash[:year].to_i, date_hash[:mon].to_i, date_hash[:mday].to_i)
        end

        def self.term(value)
          "%#{value.gsub(/\s+/, '%')}%"
        end
      end
    end
  end
end
