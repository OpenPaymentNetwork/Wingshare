# Wingshare
A demo application for the WingCash API. This is a Ruby/Sinatra app.
It uses the OAuth2 ruby gem. Users who visit the app see a list
of other users. When the user authorizes the app their name is
added to the list. The list is not persistent. When the app
is restarted the list is cleared.

This app can be deployed on Heroku using the 'Celadon Cedar' stack.

## Installation
You are strongly encouraged to run this app on Linux with the following:

 * Ruby (MRI) 1.9.2, Rubygems, and Bundler
 * Git
 * Heroku client (if you want to deploy to Heroku)

To install, just fork and clone the repository. You will have to set
your app credentials in your environment like this:

    export WING_ID=123456789 #your app's client id
    export WING_SC=blahblahblahblah #your app's client secret

Now you can run the app using bundle:

    bundle exec ruby web.rb -p 5000

