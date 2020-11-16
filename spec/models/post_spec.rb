require 'rails_helper'

RSpec.describe Post, type: :model do
  
  it { should have_many(:comments).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:title_link) }
 
end
