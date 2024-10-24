require 'rails_helper'

RSpec.describe 'layouts/application', type: :view do
  it 'renders the base layout structure' do
    render

    expect(rendered).to have_tag('html') do
      with_tag('head') do
        with_tag('title', text: 'ASoc')
        with_tag('meta[name="viewport"]')
        with_tag('meta[name="description"]')
      end

      with_tag('body') do
        with_tag('header')
        with_tag('main')
        with_tag('footer')
      end
    end
  end

  it 'allows content_for title override' do
    view.content_for(:title) { 'Custom Title' }
    render
    expect(rendered).to have_title('Custom Title')
  end

  it 'includes necessary asset tags' do
    render
    # expect(rendered).to have_tag('link[rel="stylesheet"]')
    expect(rendered).to have_tag('script', with: { 'data-turbo-track': 'reload' })
  end
end
