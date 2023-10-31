Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
  #pending "Fill in this step in movie_steps.rb"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |movie1, movie2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page).to have_content(movie1)
  expect(page).to have_content(movie2)
  #fail "Remove this step from your .feature files"
  movie1_position = page.body.index(movie1)
  movie2_position = page.body.index(movie2)
  expect(movie1_position).to be < movie2_position
  #pending "Fill in this step in movie_steps.rb"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
    if uncheck
      uncheck "ratings_#{rating}"
    else
      check "ratings_#{rating}"
    end
  end
  #pending "Fill in this step in movie_steps.rb"
end

# Part 2, Step 3

#Then /^I should (not )?see the following movies: (.*)$/ do |no, movie_list|
  # Take a look at web_steps.rb Then /^(?:|I )should see "([^"]*)"$/
  #movies = movie_list.split(', ').map(&:strip)
  #movies.each do |movie|
    #if no.nil?
      #step %{I should see "#{movie}"}
    #else
      #step %{I should not see "#{movie}"}
    #end
  #end
  #pending "Fill in this step in movie_steps.rb"
#end

Then('I should see the following movies:') do |table|
    movie_titles = table.raw.flatten
    movie_titles.each do |title|
      expect(page).to have_content(title)
    end
  end

  Then('I should not see the following movies:') do |table|
    movie_titles = table.raw.flatten
    movie_titles.each do |title|
      expect(page).not_to have_content(title)
    end
  end


Then /I should see all the movies/ do
  # Make sure that all the movies in the app are visible in the table
  #pending "Fill in this step in movie_steps.rb"
  rows = page.all('table#movies tbody tr').length
  expect(rows).to eq Movie.count
end

### Utility Steps Just for this assignment.

Then /^debug$/ do
  # Use this to write "Then debug" in your scenario to open a console.
   require "byebug"; byebug
  1 # intentionally force debugger context in this method
end

Then /^debug javascript$/ do
  # Use this to write "Then debug" in your scenario to open a JS console
  page.driver.debugger
  1
end



Then /'complete the rest of of this scenario'/ do
  # This shows you what a basic cucumber scenario looks like.
  # You should leave this block inside movie_steps, but replace
  # the line in your scenarios with the appropriate steps.
  #expect(page).to have_content(movie1)
  #expect(page).to have_content(movie2)
  #fail "Remove this step from your .feature files"
  #movie1_position = page.body.index(movie1)
  #movie2_position = page.body.index(movie2)
  #expect(movie1_position).to be < movie2_position
end
