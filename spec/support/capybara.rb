Capybara.register_driver :remote_selenium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument("--headless")
  options.add_argument("--window-size=1400,1400")
  options.add_argument("--no-sandbox")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    url: "http://localhost:4444/wd/hub",
    options: options
  )
end

Capybara.configure do |config|
  config.server = :puma, { Silent: true }
  config.server_host = "0.0.0.0"
  config.always_include_port = true
end

RSpec.configure do |config|
  config.before(:each, type: :system) do
    Capybara.app_host = "http://host.docker.internal:#{Capybara.server_port}"

    driven_by :remote_selenium_headless
  end
end