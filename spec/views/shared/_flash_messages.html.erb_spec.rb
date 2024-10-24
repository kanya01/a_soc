require 'rails_helper'

RSpec.describe 'shared/_flash_messages', type: :view do
  it 'renders flash messages with proper styling' do
    flash[:notice] = 'Success message'
    flash[:alert] = 'Error message'

    render partial: 'shared/flash_messages'

    expect(rendered).to have_tag('.flash-message.notice', text: 'Success message')
    expect(rendered).to have_tag('.flash-message.alert', text: 'Error message')
  end
  it 'includes dismiss buttons' do
    flash[:notice] = 'Test message'

    render partial: 'shared/flash_messages'

    expect(rendered).to have_tag('button.dismiss')
  end
end
