require 'rails_helper'

RSpec.describe Job do

	let(:job){build_stubbed(:job)}

	it "is valid with example attributes" do
    expect(job.valid?).to eq(true)
  end 

	it "rejects any weird charcters in Job titles" do
  names = %w[ <> !st3v3 @dav1d &*$<>]
    names.each do |name|
      job.title = name
      job.valid?
      expect(job.errors[:title].any?).to eq(true)
    end
  end
end