def person_attributes(overrides = {})
  {
    firstname:    "Peter",
    lastname:     "Perfect",
    email:        "example@example.com",
    phone:        "07777777777"
  }.merge(overrides)
end

def property_attributes(overrides = {})
  {
    house_name_no: '1',
    address1:      "Electric Avenue",
    address2:       "Citytown",
    postcode:       "BN1 7HZ",
    rent_per_week:  100.00
  }.merge(overrides)
end