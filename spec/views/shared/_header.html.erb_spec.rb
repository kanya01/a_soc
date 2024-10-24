require 'rails_helper'

RSpec.describe 'shared/_header', type: :view do
  it 'renders the navigation header' do
    render partial: 'shared/header'

    expect(rendered).to have_tag('header') do
      with_tag('nav') do
        with_tag('a.brand', with: { href: root_path })
      end
    end
  end
end
