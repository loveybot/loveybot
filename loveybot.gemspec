Gem::Specification.new do |s|
  s.name        = 'loveybot'
  s.version     = '0.0.0'
  s.date        = '2012-05-25'
  s.summary     = "Loveybot loves Rubyists!"
  s.description = "Send some love to the last person making a Ruby Gist on Github!"
  s.authors     = ["Mark Tabler", "Elise Worthy"]
  s.email       = 'mark@beforewego.net'
  s.files       = ["lib/loveybot.rb"]
  s.add_dependency('hashie')
  s.add_dependency('json')
  s.add_dependency('httparty')
  s.homepage    =
    'https://github.com/loveybot/loveybot'
end