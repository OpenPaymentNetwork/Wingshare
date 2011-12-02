require 'sinatra'
require 'haml'
require 'oauth2'
require 'json'

auth_url="http://lucia:5000/authorized"
configure do
    Users={}
    id=ENV["WING_ID"]
    secret=ENV["WING_CS"]
    Client=OAuth2::Client.new(id, secret, 
        :site => "https://api1.wingcash.com",
        :authorize_url => "https://wingcash.com/authorize",
        :token_url => "/token",
        );
    set :auth_link, Client.auth_code.authorize_url(
        :redirect_uri => auth_url,
        :state => 'confusion')
end

get '/' do
    # views/index.haml
    haml :index
end

get '/authorized' do
    atoken = params['code']
    begin
      token = Client.auth_code.get_token(atoken,
        :redirect_uri => auth_url)
      info = token.get('/me').parsed
      Users[info['id']]=info
      # views/welcome.haml
      haml :welcome, :locals => {:info => info}
    rescue OAuth2::Error
      # views/error.haml
      haml :error
    end
end
