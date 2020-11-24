# QutoParsing

**English**
CLI application for parsing data of used cars from website quto.ru. This application parses such data as the link to the car, the price of the car, its mileage and the year of production. Data parsing is carried out only on the first page!

**Russin**
Консольное приложение для парсинга данных поддержанных автомобилей с сайта quto.ru. Данное приложение парсит такие данные как ссылка на автомобиль с пробегом, стоимость автомобиля, его пробег и год производства. Парсинг осуществляется только по первой странице!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'quto_parsing'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install quto_parsing

## Usage

1) Clone this repository: git clone https://github.com/Aleksandr15/quto_parsing.git
2) Go to the directory with the repository: cd quto_parsing
3) Execute command: bundle install
4) Run the parser
Example: ruby prog.rb Renault Logan 
