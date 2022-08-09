# frozen_string_literal: true

module Trailblazer
  class Finder
    ORM_ADAPTERS = %w[ActiveRecord Sequel].freeze
    PAGING_ADAPTERS = %w[Kaminari WillPaginate].freeze

    module Base
      def self.included(base)
        base.include Helpers::Basic
        base.include Helpers::Sorting
        base.extend Finder::Dsl
      end

      attr_reader :signal, :errors

      def initialize(options = {}) # rubocop:disable Style/OptionHash
        config = self.class.config
        ctx = {config: config, options: options}
        @signal, (ctx, *) = Activities::Find.call([ctx, {}])
        @options = options
        @errors = ctx[:errors] || {}
        @find = ctx[:finder]
      end

      def fetch_result
        result = @find.query self
        result
      end

      def fetch_result_all
        result = @find.query_all self
        result
      end
    end
  end
end
