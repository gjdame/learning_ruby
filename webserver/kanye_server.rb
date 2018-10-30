require 'socket'
require 'rack'


app = KanyeQuotes.new

server = TCPServer.new 5555

while session = server.accept
      request = session.gets
      puts request

      #clean path
      method, full_path = request.split(' ')
      #check for request query
      path, query = full_path.split('?')

      status, headers, body = app.call({
      'REQUEST_METHOD' => method,
      'PATH_INFO' => path,
      'QUERY_STRING' => query
      })

      session.print "HTTP/1.1/ #{status}\r\n"
      headers.each do |key, value|
            session.print "#{key}: #{value}\r\n"
      end

      session.print "\r\n"

      body.each do |part|
            session.print part
      end
      session.close
end