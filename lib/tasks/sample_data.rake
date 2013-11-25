namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Derya Akcakaya",
                 email: "derya.akcakaya@gmail.com",
                 password: "deryaa",
                 password_confirmation: "deryaa",
                 admin: true)
    User.create!(name: "Selim Hendrickson",
                 email: "selimhendrickson@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
    5.times do
      title = Faker::Lorem.sentence(5)
      quiz = Quiz.create!(title: title)
      10.times do
        content = Faker::Lorem.sentence(10)
        answer = Faker::Lorem.word
        quiz.questions.create(content: content, answer: answer)
      end
    end
  end
end
