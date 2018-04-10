require 'rails_helper'

RSpec.describe Worktype do

	let(:worktype){build_stubbed(:worktype)}

	it "is valid with example attributes" do
    expect(worktype.valid?).to eq(true)
  end 

	it "rejects any weird charcters in worktype titles" do
  names = %w[ <> @%*st3v3 @dav1d &*$<>]
    names.each do |name|
      worktype.title = name
      worktype.valid?
      expect(worktype.errors[:title].any?).to eq(true)
    end
  end

	it "accepts in titles with specific punctuation" do
  names = %w[ Electrical. Rat-Proofing Carpentry ]
    names.each do |name|
      worktype.title = name
      worktype.valid?
      expect(worktype.errors[:title].any?).to eq(false)
    end
  end
end