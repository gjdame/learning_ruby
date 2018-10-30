require 'socket'
require 'uri'

#files to be served from this location
WEB_ROOT = './public'

CONTENT_TYPE_MAPPING = {
  'html' => 'text/html',
  'txt' => 'text/plain',
  'png' => 'image/png',
  'jpg' => 'image/jpeg'
}


DEAFULT_CONTENT_TYPE = 'application/octet-stream'

#parse file extension and finds type of content
def content_type(path)
		#split on last period
		extension = File.extname(path).split(".").last
		CONTENT_TYPE_MAPPING.fetch(extension, DEAFULT_CONTENT_TYPE)
end

#takes request line, strips uncessary pieces and joins with web root path
def requested_file(request_line)
	request_uri = request_line.split(" ")[1]
	path = URI.unescape(URI(request_uri).path)

	File.join(WEB_ROOT, path)
end

server = TCPServer.new('localhost', 5555)

loop do
	session = server.accept
	request_line = session.gets

	puts request_line

	path = requested_file(request_line)

	#check if file exists and is not a directory
	if !File.exist?(path) && !File.directory?(path)
		File.open(path, "rb") do |file|
			session.print "HTTP/1.1 200 OK\r\n"
			session.print "Content-Type: #{content_type(file)}\r\n}" +
				"Content-Length: #{file.size}\r\n" +
				"Connection: close\r\n"
		session.print "\r\n"

		IO.copy_stream(file, socket)
		end
	else
		error_message = "File Not Found"
		session.print "HTTP/1.1 404 Not Found\r\n" +
			"Content-Type: text/plain\r\n" +
			"Content-Length: #{error_message.size}\r\n" +
			"Connection: close\r\n"
		session.print "\r\n"

		socket.print error_message
	end
end