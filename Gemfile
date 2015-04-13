source 'http://rubygems.org'

gem 'rails', '4.2.0'
gem 'therubyracer'
gem 'rename'
gem 'rspec-activemodel-mocks'

# Asset template engines
# Use SCSS for stylesheets
gem 'sass-rails', '5.0.1'
gem 'coffee-script'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '2.5.3'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '4.1.0'
# Turbolinks makes following links in your web application faster.
gem 'turbolinks', '2.3.0'
# Build JSON APIs with ease
gem 'jbuilder', '2.2.3'

# gem 'cocoon', :path => '../cocoon'
# gem 'cocoon', :git => 'https://github.com/nathanvda/cocoon'
gem 'cocoon', '~> 1.2.0'

# use master version of simple-form for twitter-bootstrap integration
gem 'simple_form', '~> 3.1.0'

# Use jquery as the JavaScript library
gem 'jquery-rails', '4.0.3'
gem 'bootstrap-sass', '~> 3.3.0'

# paginations gem
gem 'will_paginate', '3.0.7'
gem 'bootstrap-will_paginate', '0.0.10'

gem "slim"
gem "slim-rails", :require => false

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
	# Spring speeds up development by keeping your application running in the backgroud
   	gem 'spring', '1.1.3'
   	# Access an IRB console on exception pages or by using <%= console %> in views
   	gem 'web-console', '2.0.0.beta3'
	gem 'rspec-rails', '~> 3.0'
	# Use sqlite3 as the database for Active Record
	gem 'sqlite3', '1.3.9', :require => 'sqlite3'
end

group :test do
	gem 'guard-rspec'
	gem 'capybara'
	gem 'launchy'
end

group :production do
	gem 'pg', '0.17.1'
	gem 'rails_12factor', '0.0.2'
	gem 'puma', '2.11.1'
end
