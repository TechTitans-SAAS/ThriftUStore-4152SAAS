# README
Welcome to **ThriftyUStore** website!

Your one-stop marketplace for buying and selling among international students. Discover a community that saves together.

## Team Members:
1. Haowen Xu - hx2364
2. Zhicheng Zou - zz3105
3. Wenjia Zhang - wz2647
4. Meixuan Lu - ml4965


## How To Run:
***You need to add your own ".env" file with the credentials in order to use Google Authentication.
The format should follow ".env_example" file.***

1. cd into ThriftUStore repo
2. run ``bundle install`` to install gems
3. run ``bin/rails db:migrate`` to update database.
4. run ``bundle exec rails s`` to start the server.
5. run ``rake spec`` to run the rspec tests
6. run ``bundle exec cucumber --guess`` to run the cucumber tests.


## Deployment:

### Link to Deployment: 
https://ghoulish-phantom-17472-ad85f4912cba.herokuapp.com/


#### The database run in Heroku is PostgreSql, the database run in local is sqlite3. Before push to Heroku, run ``heroku run rake db:migrate`` to update the database in the Heroku.


##### 
