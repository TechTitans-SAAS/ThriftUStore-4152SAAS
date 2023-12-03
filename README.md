# README
Welcome to **ThriftyUStore** website!

Your one-stop marketplace for buying and selling among international students. Discover a community that saves together.

![Website Image](app/assets/images/website.png)


## Team Members:
1. Haowen Xu - hx2364
2. Zhicheng Zou - zz3105
3. Wenjia Zhang - wz2647
4. Meixuan Lu - ml4965

## Updates for the Demo Sprint:
1. Revamped the CSS style across the entire website to enhance its visual appeal and overall user experience.
2. Implemented a new "wish list" feature that allows users to effortlessly add or remove items, as well as conveniently view all items in their wish list.
3. Introduced a functionality enabling users to mark an item as sold by entering the buyer's email. Once marked as sold, the status will be prominently displayed on the respective item page.
4. Empowered buyers to numerically rate items on a scale of 1 to 5. The assigned item rating will be prominently showcased on the item detail page.
5. Implemented a user-specific rating system derived from feedback provided by other users who have purchased items posted by the current user. The buyer's rating will be displayed on each item page associated with the user's postings.
6. Incorporated a new sorting function allowing users to arrange items based on the seller's rating, providing an additional layer of customization and convenience.


## How To Run:
***You need to add your own ".env" file with the credentials in order to use Google Authentication.
The format should follow ".env_example" file.***

1. cd into ThriftUStore repo
2. run ``bundle install`` to install gems
3. run ``bin/rails db:migrate`` to update database.
4. run ``bundle exec rails s`` to start the server.
5. run ``bundle exec rake spec`` to run the rspec tests
6. run ``bundle exec rake assets:precompile`` and ``bundle exec cucumber --guess`` to run the cucumber tests.


## Deployment:

### Link to Deployment: 
https://ghoulish-phantom-17472-ad85f4912cba.herokuapp.com/


#### The database run in Heroku is PostgreSql, the database run in local is sqlite3. Before push to Heroku, run ``heroku run rake db:migrate`` to update the database in the Heroku and run ``git push heroku main``. To clear the database, run ``heroku pg:reset postgresql-encircled-88880``.
``

## Updates on Sprint2:
1. Item Comments - We enabled the functionality to allow users to ***add/delete/update*** comments to the items posted to the website.
2. Search Items - We implemented the search function to match any potential query on the price and item title.
3. Filter Items - We implemented the filter function to sort the posted items on price and item name.
4. Refine the CSS style, including using bootstrap to make the webpage visually appealing.
5. Add navigation header to each page to allow easy access.
6. Included some simple test data to the database for demonstration.
7. Enabled Google Oauth2 login.
