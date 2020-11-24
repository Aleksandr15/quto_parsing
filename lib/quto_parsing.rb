# frozen_string_literal: true

require 'watir'
require 'json'

module QutoParsing
  def scraping
    array = []
  
    if ARGV[0].nil? || ARGV[1].nil?
      abort '0'
    end
  
    browser = Watir::Browser.new
  
    obj = matching_brand(browser)
    brand = obj[0]
    model = obj[1]
  
    browser.goto("https://quto.ru/inventory/msk/#{brand}/#{model}?condition=trade_in")
  
    card = browser.divs(class: 'cardServiceOffer2')
    card.each do |c|
      auto_link = c.link(href: %r{/inventory/msk/#{brand}/#{model}/[\w\d]+/\d+}).href
      auto_price = c.div(class: 'price').text.delete ' р.'
      info_items = c.lis(class: 'infoItem')
      auto_year = info_items[0].text.delete ' г.'
      auto_mileage = info_items[1].text.delete ' км'
      array.push(
        link: auto_link,
        price: auto_price,
        year: auto_year,
        mileage: auto_mileage
      )
    end
  
    browser.close
    total = array.size
    puts JSON.pretty_generate(array)
    puts "Total records: #{total}"
  end
  
  def matching_brand(browser)
    a = []
    brand_t = []
    txt_container = []
  
    browser.goto 'quto.ru'
    browser.span(text: 'Все марки').click
  
    element_c = browser.div(class: 'modals').child.as(class: 'link')
    element_c.each do |i|
      brand_text = i.text
      brand_link = i.href.gsub('https://quto.ru/', '')
      a.push(
        text: brand_text,
        link: brand_link
      )
    end
  
    a.each { |g| txt_container << g[:text] }
  
    argv_array_b = compound_words(*txt_container)
  
    if txt_container.include?(argv_array_b[0]) || txt_container.include?(argv_array_b[1])
      a.each do |h|
        if h.value?(argv_array_b[0]) || h.value?(argv_array_b[1])
          brand_t << h[:link]
        end
      end
    else
      abort 'Результатов нет!'
    end
  
    brand = brand_t.join
  
    model_func = matching_model(browser, brand, *txt_container)
    return brand, model_func
  end
  
  def matching_model(browser, brand, *txt_container)
    m = []
    link_model = []
    model_container = []
    browser.goto("https://quto.ru/inventory/msk/#{brand}")
  
    m_collection = browser.as(href: %r{/inventory/msk/#{brand}/[\w\d]+$})
    m_collection.each do |i|
      m_txt = i.text
      m_link = i.href.gsub("https://quto.ru/inventory/msk/#{brand}/", '')
      m.push(
        model_name: m_txt,
        model_link: m_link
      )
    end
    m.each { |i| model_container << i[:model_name] }
  
    argv_array_m = compound_words(*txt_container)
  
    if model_container.include?(argv_array_m[2]) || model_container.include?(argv_array_m[3])
      m.each do |h|
        if h.value?(argv_array_m[2]) || h.value?(argv_array_m[3])
          link_model << h[:model_link]
        end
      end
    else
      abort 'Результатов нет!'
    end
  
    return link_model.join
  end
  
  def compound_words(*txt_container)
    if txt_container.include?(ARGV[0])
      one_word = ARGV[0]
      model_one = ARGV[1..ARGV.size - 1].join ' '
    else
      two_word = ARGV[0] + ' ' + ARGV[1]
      model_two = ARGV[2..ARGV.size - 1].join ' '
    end
    return one_word, two_word, model_one, model_two
  end
end
