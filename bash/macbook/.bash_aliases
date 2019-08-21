# APPLICATION ALIASES
alias actmon="open /Applications/Utilities/Activity\ Monitor.app"
alias calc="open /Applications/Calculator.app"
alias chrome="open /Applications/Google\ Chrome.app"

# DIRECTORY ALIASES
alias analytics='cd ~/Documents/git/myStrength_Analytics'
alias adjuftments='atom ~/Documents/git/Adjuftments'
alias analytics='atom ~/Documents/git/myStrength_Analytics'
alias tableau='atom ~/Documents/git/tableau'
alias juftin='atom ~/Documents/git/Juftin-Python'

# ADJUFTMENTS
alias cd_adjf="cd ~/Documents/git/Adjuftments"
alias get_adjuftments="rsync -ravz -e ssh \
  --exclude='.git' --exclude='__pycache__' \
  pi@192.168.0.25:/home/pi/Documents/Python/Adjuftments/ \
  ~/Documents/git/Adjuftments"

# BASH INTERACTIONS
alias cls="clear"
alias c='clear'
alias ls='ls -G -a -F'
alias reload="source ~/.bash_aliases"
alias new_alias="nano ~/.bash_aliases"

#AWS CONFIG
alias cleardata="export AWS_DEFAULT_PROFILE=cleardata"

# ANALYTICS REPO
alias temp_git="atom ~/Documents/temp_git/myStrength_Analytics/"
alias swapcreds="/Users/justin/Documents/Shortcuts/swapcreds.sh"
alias unswapcreds="/Users/justin/Documents/Shortcuts/unswapcreds.sh"
alias reporting_db="/Users/justin/Documents/Shortcuts/mysql_docker.sh"
alias check_nightly="awslogs get /ecs/analytics-nightly --start='1m ago'"
alias get_database='aws s3 cp s3://mystrength-deidentification-dr/rstrengthprod_deidentified.sql ~/src/db/ \
  mysql -h db.mystrength.dev -u juftin --password=P@ssw0rd1 --default-character-set=utf8 -e "DROP DATABASE mystrength_reporting;" \
  mysql -h db.mystrength.dev -u juftin --password=P@ssw0rd1 --default-character-set=utf8 -e "CREATE DATABASE mystrength_reporting DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;" \
  mysql -h db.mystrength.dev -u juftin --password=P@ssw0rd1 mystrength_reporting --default-character-set=utf8 < ~/src/db/rstrengthprod_deidentified.sql'
alias db_backup="sh /Users/justin/src/db/restore_me.sh"
alias run_nightly="/Users/justin/Documents/git/myStrength_Analytics/integrations/python_tasks/nightly.py nightly"

# GIT FUNCTIONS AND ALIASES
alias cd_git="cd /Users/justin/Documents/git"
alias check='function _check(){ git checkout $1; };_check'
alias git-remove-untracked='git fetch --prune && git branch -r | \
  awk "{print \$1}" | \
  egrep -v -f /dev/fd/0 <(git branch -vv | \
  grep origin) | \
  awk "{print \$1}" | \
  xargs git branch -d'

# SSH CONNECTIONS
alias sshjuf="ssh -X juftin@192.168.0.3 -p 42069"
alias sshjufr="ssh -X juftin@juftin.ddns.net -p 42069"
alias sshpi="ssh pi@192.168.0.25"

# SSH BONDING
alias bind='function _bind(){ ssh -L $1:192.168.0.3:$1 juftin@192.168.0.3 -p 42069; }; _bind'
alias bindr='function _bindr(){ ssh -L $1:192.168.0.3:$1 juftin@juftin.ddns.net -p 42069; }; _bindr'

# MEDIA BINDING - BIND MULTIPLE PORTS TO LOCALHOST
alias bindm="\
  echo 'LOCAL MEDIA PORTS FORWARDED: \
  9091 | 8989 | 9117 | 7878' \
  && \
  ssh -N \
  -L 9091:192.168.0.3:9091 \
  -L 8989:192.168.0.3:8989 \
  -L 9117:192.168.0.3:9117 \
  -L 7878:192.168.0.3:7878 \
  juftin@192.168.0.3 -p 42069"
alias bindmr="\
  echo 'REMOTE MEDIA PORTS FORWARDED: \
  9091 | 8989 | 9117 | 7878' \
  && \
  ssh -N \
  -L 9091:juftin.ddns.net:9091 \
  -L 8989:juftin.ddns.net:8989 \
  -L 9117:juftin.ddns.net:9117 \
  -L 7878:juftin.ddns.net:7878 \
  juftin@juftin.ddns.net -p 42069"

#DOCKER
alias dbash='function _dbash(){ docker exec -it $1 bin/bash; };_dbash'

# TEST
alias test="echo test"
