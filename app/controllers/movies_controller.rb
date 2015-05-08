class MoviesController < ApplicationController
  def search
    @title = params['title']

    # sets my initial query string
    query_url = 'http://api.rottentomatoes.com/api/public/v1.0/movies.json'
    api_key = '2pwuxewequbju5pc2ksqfphx'
    # adds movie title to end of QUERY constent and stores raw json
    uri = URI("#{query_url}?apikey=#{api_key}&q=#{@title}")
    raw_json = Net::HTTP.get(uri)

    # returns movies array containing hash key values of supporting information
    results = JSON.parse(raw_json)['movies']
    # sets first hash result to movie

    unless results.blank?
      @movie = results.first
      # set variables
      @movie_title = @movie['title']
          @movie_title = 'No Movie Returned' if @movie_title.blank?
      @movie_synopsis = @movie['synopsis']
        @movie_synopsis = 'There are no words to describe this movie.' if @movie_synopsis.blank?
      @movie_year = @movie['year']
        @movie_year = 'No year listed.' if @movie_year.blank?
      @movie_mpaa_rating = @movie['mpaa_rating']
        @movie_mpaa_rating = 'NR' if @movie_mpaa_rating.blank?
      @movie_runtime = @movie['runtime']
        @movie_runtime = 'Not listed.' if @movie_runtime.blank?

      @movie_rating_audience = @movie['ratings']['audience_rating']
        @movie_rating_audience = 'Not Reviewed' if @movie_rating_audience.blank?
      @movie_rating_a_score = @movie['ratings']['audience_score']
        @movie_rating_a_score = 'No Review Score' if @movie_rating_a_score.blank?
      @movie_rating_critics =  @movie['ratings']['critics_rating']
        @movie_rating_critics = 'Not Reviewed' if @movie_rating_critics.blank?
      @movie_rating_c_score = @movie['ratings']['critics_score']
        @movie_rating_c_score = 'No Review Score' if @movie_rating_c_score.blank?

      @movie_release_theater = @movie['release_dates']['theater']
        @movie_release_theater = Date.parse(@movie_release_theater) unless @movie_release_theater.blank?
      @movie_release_dvd = @movie['release_dates']['dvd']
        @movie_release_dvd = Date.parse(@movie_release_dvd) unless @movie_release_dvd.blank?

      @movie_poster_thumb = @movie['posters']['thumbnail']
      # image sizes = det / ori / pro / tmb
      @movie_poster_original = @movie_poster_thumb.gsub(/tmb.jpg/, 'ori.jpg')
    end

  end

end
