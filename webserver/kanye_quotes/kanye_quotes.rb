# kanye_quotes.rb
require_relative 'quotes'

class KanyeQuotes

  def call(env)
  	case env['REQUEST_PATH']
  	when '/'
  		status = '200'
  		headers = {"Content-Type" => "text/html"}
  		response(status, headers) do
  			erb :index
  		end
  	when '/quotes'
  		#generate random Kanye quote when at quotes path
  		quotes = Quotes.new.generate
  		status = '200'
  		headers = {"Content-Type" => "text/html"}
  		response(status, headers) do
  			erb :quotes, quote: quotes
  		end
  	else
  		#render 404 not found error
  		status = '404'
  		headers = {"Content-Type" => 'text/html', "Content-Length" => '56'}
  		response(status, headers) do
  			erb :error_404
  		end
  	end
  end

  private


  def erb(filename, local = {})
  	bind = binding
  	quote = local[:quote]
  	content = File.read("views/#{filename}.erb")
  	ERB.new(content).result(bind)
  end

  def response(status, headers, body= '')
  	body = yield if  block_given?
  	[status, headers, [body]]
  end
end
