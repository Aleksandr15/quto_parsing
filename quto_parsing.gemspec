require_relative 'lib/quto_parsing/version'

Gem::Specification.new do |spec|
  spec.name          = "quto_parsing"
  spec.version       = QutoParsing::VERSION
  spec.authors       = ["Alexander Klimachev"]
  spec.email         = ["happy5android@gmail.com"]

  spec.summary       = 'QutoParsing - CLI application for parsing information from quto.ru'
  spec.description   = 'CLI application for parsing information from website quto.ru. 
  This application parses data from the first page only'
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

end
