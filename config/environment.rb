# Load the Rails application.
require_relative 'application'

# used for text in footer
ENV['COOP_FULL_NAME']   = 'Fictional Housing Cooperative Ltd'
ENV['COOP_FOOTER']    	= 'A fully mutual cooperative registered with the financial services authority under the industrial & provident societies act, 1965. Registration number: XXXXXX'
ENV['COOP_ADDRESS']			=	'Fictional House, Fiction Street, ZZ1 1ZZ'
# defaults for page title and meta description if not set with title and description helpers in view
ENV['COOP_NAME']				=	'Fictional Housing Coop'
ENV['COOP_SHORT_NAME']	=	'Fictional'
ENV['COOP_DESCRIPTION']	=	'Fictional is a self-managing housing coop based in Fiction Town'

# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

# Initialize the Rails application.
Rails.application.initialize!
