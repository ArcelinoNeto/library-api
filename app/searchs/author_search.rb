class AuthorSearch < Searchlight::Search
    def base_query
        Author.all
    end
    
    def search_name
        query.where('name LIKE ?', "%#{name}%")
    end
  
    def search_genre_predominant
        query.where('genre_predominant LIKE ?', "%#{genre_predominant}%")
    end

    def search_years_old
        query.where(years_old: options[:years_old])
    end

    def search_years_old_above
        query.where('years_old > ?', "#{years_old_above}")
    end

    def search_years_old_less
        query.where('years_old < ?', "#{years_old_less}")
    end
end
