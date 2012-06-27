require 'rack'

use Rack::Static, :urls => ['/'], :root => 'public'
run lambda { |env| [ 404, 'Not Found', {} ] }
