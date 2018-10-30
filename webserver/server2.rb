require 'socket'
require 'rack'
require 'rack/lobster'

#app = Proc.new do
#     ['200', {'Content-Type' => 'text/html'}, ["Hello World #{Time.now}"] ]
#end
app = Rack::Lobster.new

server = TCPServer.new 1234

loop do
      #session = server.accept
      #Thread.start(server.accept) do |session|
      puts "Parent: #{Process.pid}"
      name = fork do
            session = server.accept
            puts "Child: #{Process.pid}"
            puts "Parent: #{Process.ppid}"
            request = session.gets
            puts request

            #parse path to get method (GET, POST, etc) and path
            method, full_path = request.split(' ')

            #get query
            path, query = full_path.split('?')


            status, headers, body = app.call({
                  'REQUEST_METHOD' => method,
                  'PATH_INFO' => path,
                  'QUERY_STRING' => query
            })

            session.print "HTTP/1.1 #{status}\r\n"

            headers.each do |key, value|
                  session.print "#{key}: #{value}\r\n"
            end

            session.print "\r\n"

            body.each do |line|
                  session.print line
            end
            session.close

      end
      Process.waitall
      puts "Out of session pid: #{name}"

end

