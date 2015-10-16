# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie 

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
 end


 When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
 end

 Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating| 
   result=false
   all("tr").each do |tr|
     if tr.has_content?(title) && tr.has_content?(rating)
       result = true
       break
     end
   end  
  expect(result).to be_truthy
 end

 When /^I have visited the Details about "(.*?)" page$/ do |title|
   visit movies_path
   click_on "More about #{title}"
 end

 Then /^(?:|I )should see "([^"]*)"$/ do |text|
    expect(page).to have_content(text)
 end

 When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
 end

#/* --------------------------------------------------------------------------------------------- */

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|

 movies_table.hashes.each do |movie|
 Movie.create movie
  end
end


When(/^I clicked "(.*?)" link$/) do |arg1|
  click_on "Movie Title"
end

Then /^I expect to see "(.*)" before "(.*)"$/ do |arg1, arg2|
 titleCompare = page.body.to_s 
       if titleCompare.index(arg1)!= nil && titleCompare.index(arg2)!=nil
               if titleCompare.index(arg1) < titleCompare.index(arg2)
               else
               assert false,”fail”
               end
       else
               assert false,”fail”
       end
 
end

When /^I clicked the "(.*?)" link$/ do |check|
 click_on "Release Date"
end

Then /^I expect to see "(.*)" before I see "(.*)"$/ do |check, date|
 dateCompare = page.body.to_s 
       if dateCompare.index(check)!= nil && dateCompare.index(date)!=nil
               if dateCompare.index(check) < dateCompare.index(date)
               else
               assert false,”fail”
               end
       else
               assert false,”fail”
       end
end


When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|

  page.uncheck("ratings_G")
  page.uncheck("ratings_PG")
  page.uncheck("ratings_PG-13")
  page.uncheck("ratings_R")
  stringArray = arg1.split(", ")
  stringArray.each do |x|
    string = "ratings_"
    string << (x)
    page.check(string)
  end
  click_button('Refresh')
end


Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  ratingMatch = true
  ratingsArray = arg1.split(", ")
  ratings = {"G" => false, "PG"=> false, "PG-13" => false, "R" => false}
  ratingsArray.each do |x|
    if(ratingsArray == "G")
     ratings["G"] = true
    elsif(ratingsArray == "PG")
      ratings["PG"] = true
    elsif(ratingsArray == "PG-13")
      ratings["PG-13"] = true
    elsif(ratingsArray == "R")
      ratings["R"] = true
    end
  end
end

Then /^I should see all of the movies$/ do
  Movie.all
end



