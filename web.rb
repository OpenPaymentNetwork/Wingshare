require 'sinatra'
require 'haml'
require 'oauth2'
require 'json'

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
        :redirect_uri => 'http://lucia:5000/authorized',
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
        :redirect_uri => 'http://lucia:5000/authorized')
      info = token.get('/me').parsed
      Users[info['id']]=info
      "<h3>UserInfo:</h3>"+
          "<div>Welcome <a href='#{info['url']}'>#{info['display_name']}</a>."+
          "<br/><a href='/'>Continue</a>"+
          "</div>"
    rescue
      #puts Client.id
      haml <<EOX
%h3= $!.code || "Oops!"
%div{:style=>"border: dotted firebrick; width: 320px"}
  %span= $!.description
%div
  %a{:href=>"/"} Continue
EOX
    end
end
