alias r="rails"

github_connect() {
  git remote add origin "$1.git"
  echo "Your app is now connected to GitHub."
}

github_push() {
  echo "Pushing all changes to GitHub"
  git add -A
  git commit -m "$1"
  git push
}

github_catchup() {
  echo "Catching up..."
  git clean -df
  git checkout .
  git pull --rebase
  rake db:schema:load
  rake db:seed
  echo "Done."
}
