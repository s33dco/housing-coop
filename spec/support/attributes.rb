def person_attributes(overrides = {})
  {
    firstname:                 "Percy",
    lastname:                  "Percy",
    email:                     "example@example.com",
    phone:                     "07777777777",
    password:                  "password",
    password_confirmation:     "password",
    admin:                    true,
    property_id: '1'

  }.merge(overrides)
end

def property_attributes(overrides = {})
  {
    name_or_number: '1',
    address1:      "Electric Street",
    address2:       "Citytown",
    postcode:       "BN1 7HZ",
    rent_per_week:  70.00,
    last_day_of_rent_period: (Time.now.to_date - 15.days)
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
    cost:            123.45,
    date:            "2017-12-25",
    details:         'Rat-proofed underneath the house, rewired the downstairs plug Sockets. They did an excellent job.'
  }.merge(overrides)
end

def rent_attributes(overrides = {})
  {
    payment:         123.45,
    notes:           "additional payment made",
    date:            "2017/12/01"
  }.merge(overrides)
end

def calendar_attributes(overrides = {})
  {
    date_time:       "2017-12-25 19:30:00",
    where:           "Meeting Space, Lordship Lane",
    title:           "Annual General Meeting",
    details:         "Agenda points sent by email"
  }.merge(overrides)
end

def job_attributes(overrides = {})
  {
    title:           "Maintenance Officer",
    email:            "maintenance@example.org.uk"
  }.merge(overrides)
end

def role_attributes(overrides = {})
  {
    role_start:      "2018-12-31",
    role_end:        "2019-01-01" 
  }.merge(overrides)
end

def worktype_attributes(overrides = {})
  {
    title:      "Electrical" 
  }.merge(overrides)
end



