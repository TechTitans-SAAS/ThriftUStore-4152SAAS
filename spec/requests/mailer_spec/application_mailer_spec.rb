require 'rails_helper'

RSpec.describe ApplicationMailer, type: :mailer do
  it 'test default form is correct' do
    expect(ApplicationMailer.default[:from]).to eq('from@example.com')
  end

end
