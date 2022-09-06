require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to belong_to :author}

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:genre) }
  it { is_expected.to validate_presence_of(:puclication_date) }
  it { is_expected.to validate_presence_of(:publishing_company) }
end
