# config.ru
require 'rack'
require_relative 'kanye_quotes'

Rack::Handler::WEBrick.run(
	KanyeQuotes.new,
	:Port => 5678
	)