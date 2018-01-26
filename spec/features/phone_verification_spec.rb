# frozen_string_literal: true

describe 'Phone verification' do
  let!(:account) { create :account }

  it 'can access page' do
    visit index_path
    click_on 'Sign in'
    fill_in 'account_email', with: account.email
    fill_in 'account_password', with: account.password
    click_on 'Submit'
    visit new_phone_path
    expect(page).to have_content("Add phone")
  end

  it 'verifies phone number' do
    visit index_path
    click_on 'Sign in'
    fill_in 'account_email', with: account.email
    fill_in 'account_password', with: account.password
    click_on 'Submit'
    visit new_phone_path
    fill_in 'number', with: 'qwerty'
    click_on 'Get code'
    expect(page).to have_content("invalid")
  end

  it 'verifies phone number' do
    visit index_path
    click_on 'Sign in'
    fill_in 'account_email', with: account.email
    fill_in 'account_password', with: account.password
    click_on 'Submit'
    visit new_phone_path
    fill_in 'number', with: '+380955555555'
    click_on 'Get code'
    expect(page).not_to have_content("invalid")
  end

  it 'creates phone' do
    visit index_path
    click_on 'Sign in'
    fill_in 'account_email', with: account.email
    fill_in 'account_password', with: account.password
    click_on 'Submit'
    visit new_phone_path
    fill_in 'number', with: '+380955555555'
    click_on 'Get code'
    fill_in 'code', with: FakeSMS.messages.last.body
    click_on 'Add'
    expect(page).to have_content("UA")
  end
end
