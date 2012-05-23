require 'test_helper'

describe 'Experiencies integration' do
  it 'list experiencies' do
    e = create(:experiencie)
    visit experiencies_path
    page.text.must_include e.title
  end

  it 'can create experiencie if user' do
    login_user(create(:user))
    visit experiencies_path
    page.find "a[rel='new-experiencie']"
  end

  it 'can create experiencie' do
    login_user create(:user)
    visit new_experiencie_path
    fill_in 'experiencie_title', with: 'The title'
    fill_in 'experiencie_body', with: 'The body'
    click_submit
    e = Experiencie.last
    e.title.must_equal 'The title'
    e.body.must_equal 'The body'
  end

  it 'can update experiencie' do
    login_user create(:user)
    e = create(:experiencie)
    visit edit_experiencie_path(e)
    fill_in 'experiencie_title', with: 'My experiencie'
    click_submit
    e.reload
    e.title.must_equal 'My experiencie'
  end
end