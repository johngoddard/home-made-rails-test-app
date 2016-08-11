class Seeder
  def seed
    h = User.new(username: "John", password: "password", session_token: SecureRandom.urlsafe_base64(16))
    h1 = User.new(username: "Andrea", password: "password", session_token: SecureRandom.urlsafe_base64(16))
    h.save
    h1.save

    c1 = Cat.new(name: "Cato", owner_id: 1)
    c2 = Cat.new(name: "Moto", owner_id: 1)
    c1.save
    c2.save

    r1 = CatRentalRequest.new(cat_id: 1, user_id: 2, start_date: '2016-09-01 10:00:00', end_date: '2016-09-21 10:00:00')
    r1.save
  end
end
