namespace :dev do
  desc "Populando banco teste com dados fake "
  task setup: :environment do

    puts "Zerando o banco"
    %x(rails db:drop db:create db:migrate)
    puts "Banco zetado com sucesso"
    puts "  "

    puts "Cadastrando Autores!"

    10.times do |i|
      years_old = (
          time = Time.new
          birthdate = Faker::Date.birthday(min_age: 18, max_age: 65)
          time.year - birthdate.year
          )

      Author.create!(
        name: Faker::Book.author,
        genre_predominant: Faker::Gender.binary_type,
        years_old: years_old,
        etc: Faker::GreekPhilosophers.quote 
      )
    end

    puts "Autores cadastrados com sucesso!"
    puts "  "

    puts "Cadastrando Livros!"

    100.times do |i|
      Book.create!(
        title: Faker::Book.title,
        description: Faker::Marketing.buzzwords,
        genre: Faker::Book.genre,
        author: Author.all.sample,
        puclication_date: Faker::Date.birthday(min_age: 1, max_age: 65), 
        publishing_company: Faker::Book.publisher, 
        etc: Faker::GreekPhilosophers.quote
      )
    end
    puts "Livros cadastrados com sucesso!"

  end

end
