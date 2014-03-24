alias r="rails"

github_connect() {
  git remote add origin "$1.git"
  echo "Your app is now connected to GitHub.  Use github_push to take code snapshots and sync them to GitHub."
}

save() {
  git add -A
  git commit -m "$1"
  git push
}

github_push() {
  echo "Pushing all changes to GitHub..."
  git pull --rebase
  git add -A '.'
  git commit -m "$1"
  git push
}

github_catchup() {
  echo "Catching up..."
  git checkout -q .
  git clean -qdf
  git pull -q
  bundle install --quiet --without production
  rake ez:reset_tables
  rake db:seed
  echo
  echo "Done.  You might need to restart your rails server if it was already running."
}
