require 'socket'

routes = {
      "/" => "Hi, thanks for sitting through this guys. I know its the highlight of your week. \n
      Other available routes are about and pun",
      "/about" => "My middle name is James. I have one sister. I like cheese.",
      "/pun"  => "6:30 is the best time on a clock. Hands down!"
}


PAGE_ERROR = "Sorry, come back later. I probably still won't have anything here"

server = TCPServer.new 7777

loop do
      session = server.accept
      request = session.gets
      puts request

      #parse path to get method (GET, POST, etc) and path
      method, full_path = request.split(' ')

      #get query
      path, query = full_path.split('?')


      if routes.keys.include? path
            status = "200 OK"
            response_body = routes[path]
      else
            status = "404 Not Found"
            response_body = PAGE_ERROR
      end

      session.print "HTTP/1.1 #{status}\r\n"

      #headers.each do |key, value|
      #      session.print "#{key}: #{value}\r\n"
      #end

      session.print "\r\n"

      session.print response_body
      session.close

end


