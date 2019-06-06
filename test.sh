#!/bin/bash

export RAILS_ENV="production"
export MALLOC_ARENA_MAX=2
export SECRET_KEY_BASE="462c138ae3c6214b769b13d7c0d50c0ffeb5130bfb543e328a26ed3cd07350617a7dc7baab845eab28038a791ca028e3f6d53112a1fd5216a825c4aff641909d"
echo ""
cd /var/www/rails-helpdesk

if [[ -z "$1" ]];
then
  BRANCH="master"
else
  BRANCH=$1
fi

echo "$(tput setaf 2)Getting last changes from bitbucket$(tput sgr 0)"

#git checkout deployment
#git fetch
#git checkout $BRANCH
#git merge origin/$BRANCH


echo "$(tput setaf 2) Cleaning cache$(tput sgr 0)"
rm -Rf /var/www/rails-helpdesk/tmp/cache

while [ ! $# -eq 0 ]
do
    case "$1" in
        --migrate | -m)
            MIGRATE=TRUE
            ;;
        --precompile | -p)
            PRECOMPILE=TRUE
            ;;
        --bundle | -b)
            BUNDLE=TRUE
            ;;
    esac
    shift
done

echo "$(tput setaf 2) Bundle install!$(tput sgr 0)"
bundle install

echo "$(tput setaf 2) Running migrations$(tput sgr 0)"
RAILS_ENV=$RAILS_ENV bundle exec rake db:migrate

echo "$(tput setaf 2) Running whenever $(tput sgr 0)"
bundle exec whenever --update-crontab

echo "$(tput setaf 2) build webpack assets $(tput sgr 0)"
yarn install
NODE_ENV=production ./bin/webpack --json > /dev/null

echo "$(tput setaf 2) Precompiling assets$(tput sgr 0)"
bundle exec rake assets:precompile

echo "$(tput setaf 2) Update locales$(tput sgr 0)"
bundle exec rake locales:update

read -p "$(tput setaf 1)Press Enter to continue and restart services$(tput sgr 0)"

echo checking BroadcastSendJob...
if [[ $(bundle exec rails check_broadcast_jobs_running) == true ]]; then
  echo BroadcastSendJob is running, please try deploy later!!!
  exit 1
fi

echo "$(tput setaf 2) Restarting puma server$(tput sgr 0)"
rails_hd restart

echo "$(tput setaf 2) Restarting sidekiq$(tput sgr 0)"
kill $(ps aux | grep 'sidekiq' | awk '{print $2}')
bundle exec sidekiq -d
bundle exec sidekiq -d
bundle exec sidekiq -d
bundle exec sidekiq -d

asdb asdf asdf -i --asdf


cd /var/www/rails-helpdesk
git describe --abbrev=0 --tag > public/version.txt
git describe --abbrev=0 --tag > /var/www/helpdesk/web/version.txt

echo "$(tput setaf 2) Resend Gateway inbox failed $(tput sgr 0)"
cd /var/www/gateway && php yii observer/resend-inbox-last-failed

echo "$(tput setaf 2) ---------------------- Done!!! ---------------------$(tput sgr 0)"
