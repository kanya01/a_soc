require 'rails_helper'

RSpec.describe 'shared/_footer', type: :view do
  it 'renders the footer with copyright' do
    render partial: 'shared/footer'

    expect(rendered).to have_tag('footer') do
      with_text(/#{Time.current.year}/)
      with_text(/ASoc/)
    end
  end
end