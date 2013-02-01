def solr_execute_search(options = {})
  options.assert_valid_keys(:include, :select)
  search = yield
  unless options.empty?
    search.build do |query|
      if options[:include]
        query.data_accessor_for(self).include = options[:include]
      end
      if options[:select]
        query.data_accessor_for(self).select = options[:select]
      end
    end
  end
  search.execute
end
def solr_execute_search_ids(options = {})
  search = yield
  search.raw_results.map { |raw_result| raw_result.primary_key.to_i }
end