
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

# Single-line step scoper
When /^(.*) within (.*[^:])$/ do |step, parent|
  with_scope(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within (.*[^:]):$/ do |step, parent, table_or_string|
  with_scope(parent) { When "#{step}:", table_or_string }
end

#######TODO: page_name

Given('I am a logged-in user') do
  user = User.create(email: 'test@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When('I press the button {string}') do |button_name|
  click_button button_name
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When('I sign out') do
  click_link('Logout')
end


#When('I click the "Shop Now" button') do
  #user = User.create(email: 'test@example.com', password: 'password')
  #visit new_user_session_path
  #fill_in 'Email', with: user.email
  #fill_in 'Password', with: 'password'
  #click_button 'Log in'
  #visit items_path
#end

When('I click the "Shop Now" button') do
  if User.any?
    visit items_path
  else
    click_link("Login")
  end
end


When('I click the "Login" button') do
  click_link("Login")
end

When('I click the "Register" button') do
  click_link("Register")
end

When('I click the "My Profile" button') do
  user = User.create(email: 'test@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  visit user_path(user)
end

When('I click the "My Items" button') do
  user = User.create(email: 'test@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  visit user_my_items_path(user)
end

When('I click the "Log out" button') do
  user = User.create(email: 'test@example.com', password: 'password')
  visit new_user_session_path
  fill_in 'Email', with: user.email
  fill_in 'Password', with: 'password'
  click_button 'Log in'
  click_link("Logout")
end

When('I click the "Edit Profile" button') do
  click_link('Edit Profile')
end

When('I click the "Cancel my account" button') do
  click_button('Cancel my account')
end

When('I click the "New Item" button') do
  click_link('New Item')
  puts new_item_path
end

When('I click the "Back to Profile" button') do
  click_link('Back to Profile')
end

When('I click the "Show" button') do
  click_link('Show')
end


Then('I should see an error message {string}') do |error_message|
  expect(page).to have_content(error_message)
end

Then('I should see a confirmation message {string}') do |confirmation_message|
  expect(page).to have_content(confirmation_message)
end

Then('I should see the message {string}') do |message|
  expect(page).to have_content(message)
end

Given('I have not created any items') do
  user = User.create(email: 'test@example.com', password: 'password123')
end



When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in(field, :with => value)
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in(field, :with => value)
end


When /^(?:|I )fill in the following:$/ do |fields|
  fields.rows_hash.each do |name, value|
    When %{I fill in "#{name}" with "#{value}"}
  end
end

######TODO: update
# Example step for filling in email and password
When /^(?:|I )fill in email and password$/ do
  fill_in("Email", with: "user@example.com") # Update with actual email
  fill_in("Password", with: "password") # Update with actual password
end



When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select(value, :from => field)
end

When /^(?:|I )check (?:the\s+)?"([^"]*)"(?:\s*checkbox)?$/ do |field|
  check(field)
end

# Example step for checking "Remember Me"
And /^(?:|I )check "Remember Me"$/ do
  check("Remember Me")
end

When /^(?:|I )uncheck (?:the\s+)?"([^"]*)"(?:\s*checkbox)?$/ do |field|
  uncheck(field)
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose(field)
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file(field, File.expand_path(path))
end

When('I upload an image') do
  image_path = File.expand_path('/Users/zhang/Desktop/Ruby_logo.png', __dir__)
  attach_file('Image', image_path, make_visible: true)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)

  assert page.has_xpath?('//*', :text => regexp)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
    expect(page).not_to have_content(text)
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  regexp = Regexp.new(regexp)
  assert page.has_no_xpath?('//*', :text => regexp)
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    assert_match(/#{value}/, field_value)
  end
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  with_scope(parent) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    assert_no_match(/#{value}/, field_value)
  end
end

Then /^the "([^"]*)" field should have the error "([^"]*)"$/ do |field, error_message|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')

  form_for_input = element.find(:xpath, 'ancestor::form[1]')
  using_formtastic = form_for_input[:class].include?('formtastic')
  error_class = using_formtastic ? 'error' : 'field_with_errors'

  assert classes.include?(error_class)

  if using_formtastic
    error_paragraph = element.find(:xpath, '../*[@class="inline-errors"][1]')
    assert error_paragraph.has_content?(error_message)
  else
    assert page.has_content?("#{field.titlecase} #{error_message}")
  end
end

Then /^the "([^"]*)" field should have no error$/ do |field|
  element = find_field(field)
  classes = element.find(:xpath, '..')[:class].split(' ')
  assert !classes.include?('field_with_errors')
  assert !classes.include?('error')
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    assert field_checked
  end
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  with_scope(parent) do
    field_checked = find_field(label)['checked']
    assert !field_checked
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  assert_equal path_to(page_name), current_path
end

Then('I should be on the Edit User page') do
  expect(current_path).to eq(edit_user_registration_path)
end


Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  assert_equal expected_params, actual_params
end

Then /^show me the page$/ do
  save_and_open_page
end

Then('I should see the following items in the table:') do |table|
  actual_data = all('table tr').map { |row| row.all('th, td').map(&:text) }
  expected_data = table.raw
  expect(actual_data).to eq(expected_data)
end
