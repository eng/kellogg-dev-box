alias r="rails"

github_connect() {
  git remote add origin "$1.git"
  git add -A '.'
  git commit -m "First commit"
  git push -u origin master
  echo "Your app is now connected to GitHub.  Use github_push to take code snapshots and sync them to GitHub."
}

github_push() {
  echo "Pushing all changes to GitHub..."
  git add -A '.'
  git commit -m "$1"
  git pull --rebase origin master
  git push origin master
}

catchup() {
  echo "Catching up..."
  git checkout -q .
  git clean -qdf
  git pull -q
  bundle install --quiet --without production
  bundle exec rake ez:reset_tables
  bundle exec rake db:seed
  echo
  echo "Done.  You might need to restart your rails server if it was already running."
}
