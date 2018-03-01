# Load the Rails application.
require_relative 'application'

ENV['COOP_FULL_NAME']   = 'Dryad Housing Cooperative Ltd'
ENV['COOP_NAME']				=	'Dryad Housing Coop'
ENV['COOP_SHORT_NAME']	=	'Dryad'
ENV['COOP_FOOTER']    	= 'A fully mutual cooperative registered with the financial services authority under the industrial & provident societies act, 1965. Registration number: 28719R'
ENV['COOP_ADDRESS']			=	'43, Golf Drive, BN1 7HZ'

# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

# Initialize the Rails application.
Rails.application.initialize!
