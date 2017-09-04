require 'open-uri'
require 'json'

$foaas = "http://foaas.com/"

def foaas(command, *args)
    puts args.inspect
    if args.length > 0
        open(URI.parse(URI.encode("#{$foaas}#{command}/#{args.join('/')}")), "Accept" => "text/plain").read
    else
        puts command
        if command == 'operations'
            JSON.parse(open(URI.parse(URI.encode("#{$foaas}#{command}")), "Accept" => "text/json").read)
        else
            open(URI.parse(URI.encode("#{$foaas}#{command}")), "Accept" => "text/plain").read
        end
    end
end

