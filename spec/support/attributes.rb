def person_attributes(overrides = {})
  {
    firstname: "Peter",
    lastname: "Perfect",
    email: "example@example.com",
    phone: "07777777777"
  }.merge(overrides)
end

