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

def contractor_attributes(overrides = {})
  {
    phone:          '01234567789',
    name:           'Steve Mcqueen',
    email:          'mcqueenplumbing@gmail.com',
    details:        'expert in hot water tank'
  }.merge(overrides)
end

def maintenance_attributes(overrides = {})
  {
    worktype:        'Plumbing',
    cost:            123.45,
    details:          'Rat-proofed underneath the house, rewired the downstairs plug Sockets. They did an excellent job.'
  }.merge(overrides)
end

def rent_attributes(overrides = {})
  {
    payment:          123.45,
    notes:            "additional payement made",
    date:             "2017/12/01"
  }.merge(overrides)
end