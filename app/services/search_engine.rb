require "google-search"

class SearchEngine
  
  def self.count_results(query)
    search = Google::Search::Web.new do |search|
      search.query = query
      search.api_key = ENV['GOOGLE_API_KEY']
    end

    search.get_response.estimated_count
  end
end