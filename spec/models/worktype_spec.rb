require 'rails_helper'

describe 'a worktype' do

		it "is valid with example attributes" do
			worktype = Worktype.new(worktype_attributes)
	    expect(worktype.valid?).to eq(true)
	  end 

  	it "rejects any weird charcters in worktype titles" do
    names = %w[ <> @%*st3v3 @dav1d &*$<>]
	    names.each do |name|
	      worktype = Worktype.new(title: name)
	      worktype.valid?
	      
	      expect(worktype.errors[:title].any?).to eq(true)
	    end
	  end

  	it "accepts in titles with specific punctuation" do
    names = %w[ Electrical. Rat-Proofing Carpentry ]
	    names.each do |name|
	      worktype = Worktype.new(title: name)
	      worktype.valid?
	      
	      expect(worktype.errors[:title].any?).to eq(false)
	    end
	  end

end