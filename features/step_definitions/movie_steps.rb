# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    #  | title                   | rating | release_date |
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create(title: movie[:title], rating: movie[:rating], release_date: movie[:release_date] )
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.match ".+#{e1}.+#{e2}.+"
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split().each do |x|
    if uncheck == ""
      check("ratings_"+x)
    else
      uncheck("ratings_"+x)
    end
  end
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb

end

Then /I should(n\'t)? see the following movies/ do |should_see, movies_table|
  movies_table.hashes.each do |movie|
    if(should_see == "")
      page.should have_content(movie[:title])
    else
      assert page.has_content?(movie[:title])
    end
  end
end
