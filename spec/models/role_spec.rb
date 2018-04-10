require 'rails_helper'

RSpec.describe Role do

	let(:role){build_stubbed(:role)}
	let(:role2){build(:role, role_end: "2.years.ago")}

	it "is valid with example attributes" do
    expect(role.valid?).to eq(true)
  end 

  it "requires a start date" do
    role.role_start = ""
    role.valid?
    expect(role.errors[:role_start].any?).to eq(true)
  end

	it "requires an end date" do
	  role.role_end = ""
	  role.valid?
	  expect(role.errors[:role_end].any?).to eq(true)
	end

	it "start date cannot be after end date" do
		role2.save
    expect(role2.errors[:role_end].any?).to eq(true)
  end 
end