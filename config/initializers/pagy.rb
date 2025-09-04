Pagy::DEFAULT[:limit] = 7
require 'pagy/extras/elasticsearch_rails'
#Pagy::DEFAULT[:page]   = 1                                  # default
#Pagy::DEFAULT[:items]  = 5                                # default
Pagy::DEFAULT[:items] = 10
require 'pagy/extras/bootstrap'
require 'pagy/extras/overflow'
Pagy::DEFAULT[:overflow] = :empty_page
