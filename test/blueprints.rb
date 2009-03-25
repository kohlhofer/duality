Sham.login    { Random.firstname }
Sham.email    { Random.email }
Sham.birthday { (22 + Random.number(40)).years.ago(Random.date(400)) }
Sham.password { Random.alphanumeric(8) }

User.blueprint do
  login
  email
  password
end
