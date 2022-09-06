class BookSearch < Searchlight::Search
    def base_query
        Book.all
    end
    
    def search_title
        query.where('title LIKE ?', "%#{title}%")
    end
  
    def search_genre
        query.where('genre LIKE ?', "%#{genre}%")
    end
    
    # maior que:
    def search_puclication_date_above
        entry_date = options[:puclication_date_above]
        converted_date = entry_date.to_date
        query.where('puclication_date >= ?', "#{converted_date}")
    end

    # menor que:
    def search_puclication_date_less
        entry_date = options[:puclication_date_less]
        converted_date = entry_date.to_date
        query.where('puclication_date <= ?', "#{converted_date}")
    end

    def search_author_id
        query.where(author_id: options[:author_id])
    end

    def search_author_name
        entry_name = options[:author_name]
        query.joins(:author).where('name LIKE ?', "%#{entry_name}%")
    end
end
