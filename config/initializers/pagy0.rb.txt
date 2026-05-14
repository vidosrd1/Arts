<<<<<<< HEAD
=======
require 'pagy/extras/bootstrap' # <--- make sure this is here
>>>>>>> 208fa5493983c2ef26eb0f94e754dfe7d7bb8935
Pagy::DEFAULT[:limit] = 10#7
#Pagy::DEFAULT[:size]       = [1,4,4,1]#[1,1,1,2]#[1,2,2,1]#[1,4,4,1]                       # default
#Pagy::DEFAULT[:page_param] = :seite #:page                           # default
Pagy::DEFAULT[:page]   = 1                                  # default
Pagy::DEFAULT[:items]  = 5                                # default
#Pagy::DEFAULT[:elasticsearch_rails_pagy_search] = :pagy_search
#Pagy::DEFAULT[:elasticsearch_rails_search] = :search
#require 'pagy/extras/elasticsearch_rails'
#require 'pagy/extras/bootstrap'
#require 'pagy/extras/items'
#Pagy::DEFAULT[:items_param] = :items   # default
#Pagy::DEFAULT[:max_items]   = 100      # default
#require 'pagy/extras/overflow'
#Pagy::DEFAULT[:overflow] = :last_page#:empty_page    # default  (other options: :last_page and :exception)
