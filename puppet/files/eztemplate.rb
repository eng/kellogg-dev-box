gem 'quiet_assets', group: 'development'
gem 'hirb', group: 'development'
gem 'ez', group: 'development'

gsub_file "Gemfile", "gem 'sqlite3'", ""
gsub_file "Gemfile", "# Use sqlite3 as the database for Active Record", ""

gem_group :development, :test do
  gem 'sqlite3'
end

gem_group :production do
  gem "pg"
  gem "rails_12factor"
end

run "bundle install --without production"

# generate('starter:style cerulean -f')
# generate(:scaffold, "user", "name", "password_digest", "--no-stylesheets")

uncomment_lines "Gemfile", "bcrypt"
comment_lines 'app/controllers/application_controller.rb', /protect_from/

rake "ez:generate_yml"

git :init
git add: "."
git commit: "-m 'Generate the app'"

application <<-EOS
    I18n.enforce_available_locales = false
    Hirb.enable if defined?(Hirb)
EOS

