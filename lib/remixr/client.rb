module Remixr
  class Client
    include HTTParty
    base_uri 'api.remix.bestbuy.com/v1'
    format :json
    
    attr_reader :api_key, :store_filters, :product_filters
    
    
    def initialize(api_key=nil)
      @api_key = api_key
      @api_key ||= Remix.api_key
      
      @api_path = ''
      @store_filters = {}
      @product_filters = {}
    end
    
    def stores(filters={})
      unless @api_path.include?('stores()')
        @api_path += '+' unless @api_path.blank?
        @api_path += "stores()"
      end
      @store_filters.merge!(filters)
      self
    end
    
    def in_zip(zip)
      self.stores({'postalCode' => zip})
    end
    
    def in_region(region)
      self.stores({'region' => region})
    end
    
    
    def products(filters={})
      unless @api_path.include?('products()')
        @api_path += '+' unless @api_path.blank?
        @api_path += "products()"
      end
      @product_filters.merge!(filters)
      self
    end
    
    def fetch(options={})
      opts = {:apiKey => @api_key, :format => 'json'}
      opts.merge!(scrub_options(options))
      
      apply_store_filters
      apply_product_filters
      @api_path = URI.escape(@api_path)
      response = self.class.get("/" + @api_path, :query => opts)
      @api_path = ''
      Mash.new response
    end
    
    private
      def apply_store_filters
        if @store_filters.keys.blank? 
          @api_path.gsub!("stores()", "stores")
        else
          @api_path.gsub!("stores()", "stores(#{filter_params_string(@store_filters)})")
        end
      end
      
      def apply_product_filters
        if @product_filters.keys.blank? 
          @api_path.gsub!("products()", "products")
        else
          @api_path.gsub!("products()", "products(#{filter_params_string(@product_filters)})")
        end
      end
      
      def filter_params_string(filters)
        return "" unless filters.is_a?(Hash)
        
        filters = Mash.new filters.to_hash # calling Mash.new on a mash is bad mmmm k?
        params = []
        filters.each do |key, value|
          if value.is_a?(Hash)
            inner_hash = value
            case inner_hash.keys.first
            when "$gt"
              params << "#{key}>#{inner_hash.values.first}"
            when "$lt"
              params << "#{key}<#{inner_hash.values.first}"
            when "$gte"
              params << "#{key}>=#{inner_hash.values.first}"
            when "$lte"
              params << "#{key}<=#{inner_hash.values.first}"
            when "$ne"
              params << "#{key}!=#{inner_hash.values.first}"
            when "$in"
              params << "#{key} in(#{inner_hash.values.first.join(',')})"
            end
          elsif value.is_a?(Array)
            params << "#{key}(#{value.join(',')})"
          else
            params << "#{key}=#{value}"
          end
        end
        
        if params.blank?
          ""
        else
          "#{params.join('&')}"
        end
      end
      
      def scrub_options(options)
        options = Mash.new(options.to_hash)
        sort = options.delete('sort')
        unless sort.blank?
          if sort.is_a?(Hash)
            options['sort'] = "#{sort.keys.first}.#{sort.values.first}"
          else
            options['sort'] = sort
          end
        end
        options
      end
    
  end
end