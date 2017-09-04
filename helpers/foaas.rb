require 'open-uri'

$foaas = "http://foaas.com/"

def foaas(command, *args)
    if args.length > 0
        puts URI.parse(URI.encode("#{$foaas}#{command}/#{args.join('/')}")), "Accept" => "text/plain"
        open(URI.parse(URI.encode("#{$foaas}#{command}/#{args.join('/')}")), "Accept" => "text/plain").read
    else
        puts URI.parse(URI.encode("#{$foaas}#{command}")), "Accept" => "text/plain"
        open(URI.parse(URI.encode("#{$foaas}#{command}")), "Accept" => "text/plain").read
    end
end

