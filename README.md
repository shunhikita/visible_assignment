# VisibleAssignment

Change the way data is passed from ActionController to ActionView.

Instead of copying all the instance variables of ActionController, VisibleAssignment copy only the explicit data to the instance variable of ActionView so that it can be used in the View.

Resolve the poor visibility of what is in the instance variables used by View. For example, an instance variable defined by before_action or an instance variable defined by an included module ...etc

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'visible_assignment'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install visible_assignment


## Configuration


By default, the instance variable of the controller is not taken over by View.
When set to true, the instance variable of the controller is also copied to the View instance variable.

```rb
VisibleAssignment.configure do |config|
  config.enable_instance_variables = true # default false.
end
```

## Usage

When you want to pass an instance variable to View.

```rb
class BooksController < ApplicationController
  def index
    self.view_assign_variables = {
      books: available_books,
    } 
  end
  
  def show
    self.view_assign_variables = {
      book: current_book,
    }
  end
  
  private
    
    def available_books
      Book.available
    end
    
    def current_book
      available_books.find(params[:id])
    end
end
```

```books/index.erb
<% @books.each do |book| %>
  <p><%= book.title %></p>
<% end %>
```

```books/show.erb
<p><%= @book.title %></p>
```

When you want to pass an instance variable that is used for all actions to View

```rb
class ApplicationController < ActionController::Base
  before_action :set_global_view_assign_variables
  
  def set_global_view_assign_variables
    self.global_view_assign_variables = {
      current_user: current_user,
    }
  end
  
  private
  
    def current_user
      # ...
    end
end
```

:no_good: bad usage

Instance variables are not copied to View when enable_instance_variables is false.

```rb
class BooksController < ApplicationController
  before_action :load_book, only: %w(show)
  
  def show
  end
  
  private
    
    def load_book
      @book = Book.find(params[:id])
    end
end
```

```books/show.erb
<p><%= @book.title %></p>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/shunhikita/visible_assignment.
