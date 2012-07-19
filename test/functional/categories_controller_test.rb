# encoding: utf-8
require 'test_helper'

describe 'Categories integration' do
  it 'show category' do
    category = create(:category)
    visit category_path(category)
    page.text.must_include category.question
  end

  it 'show category proposals' do
    category = create(:category)
    p = create(:proposal, category: category)
    1.upto(3) { p.add_relation(create(:experiencie), category.user) }

    visit category_path(category)
    page.text.must_include p.title
    page.text.must_include p.summary
    page.text.must_include p.experiencies_count.to_s
  end

  it 'can create proposals inside category' do
    login_user create(:user)
    category = create(:category)
    login_user create(:user)
    visit category_path(category)
    find_link('new-proposal')
  end

  it 'creates categories' do
    phase = create(:phase)
    user = create(:user, admin: true)

    login_user(user)
    visit new_phase_category_path(phase)
    fill_in 'category_title', with: 'Mi categoría'
    fill_in 'category_question', with: '¿Qué hacemos?'
    fill_in 'category_summary', with: 'Las cositas'
    click_submit

    category = Category.last
    category.phase.must_equal phase
    category.user.must_equal user
    category.title.must_equal 'Mi categoría'
    category.question.must_equal '¿Qué hacemos?'
    category.summary.must_equal 'Las cositas'
  end
end
