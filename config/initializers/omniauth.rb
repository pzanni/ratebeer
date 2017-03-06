Rails.application.config.middleware.use OmniAuth::Builder do
 provider :github, ENV['93f2ac3927f932441dea'], ENV['8887eb80516a3823ea598d7fc57aa5f24779a498']
end