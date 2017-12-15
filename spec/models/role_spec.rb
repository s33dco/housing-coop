require 'rails_helper'

describe 'a role' do 

		it "is valid with example attributes" do
			person = Person.new(person_attributes)
			job = Job.new(job_attributes)
			role = Role.new(role_attributes)
			role.job = job
			role.person = person
	    expect(role.valid?).to eq(true)
	  end 

  it "requires a start date" do
    role = Role.new(role_start: "")
    role.valid?
    expect(role.errors[:role_start].any?).to eq(true)
  end

 it "requires an end date" do
    role = Role.new(role_end: "")
    role.valid?
    expect(role.errors[:role_end].any?).to eq(true)
  end


		it "start date cannot be after end date" do
			person = Person.new(person_attributes)
			job = Job.new(job_attributes)
			role = Role.new(role_start: "2016-01-01", role_end: "2015-12-12")
			role.job = job
			role.person = person
	    expect(role.valid?).to eq(true)
	  end 


end
