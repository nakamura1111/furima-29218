#!/bin/bash

bundle exec rspec spec/models/user_spec.rb 
bundle exec rspec spec/models/good_spec.rb
bundle exec rspec spec/models/buy_info_spec.rb 
bundle exec rspec spec/system/users_spec.rb
bundle exec rspec spec/system/goods_spec.rb 
bundle exec rspec spec/system/buys_spec.rb   

exit 0
