# BASH INTERACTIONS
alias cls="clear"
alias c='clear'
alias ls='ls -G -a -F'
alias reload="source ~/.bash_aliases"
alias new_alias="nano ~/.bash_aliases"

# ADJUFTMENTS
alias cd_adjf="cd ~/Documents/Python/Adjuftments"
alias restart_adjuftments="docker stop adjuftments ; docker rm adjuftments ; docker rmi juftin/adjuftments:latest ; cd /home/juftin/Documents/Python/Adjuftments && ./rundocker"
alias dashboard="docker exec adjuftments /home/Adjuftments/functions.py dashboard"
alias clean="docker exec adjuftments /home/Adjuftments/functions.py clean"
alias backup="docker exec adjuftments /home/Adjuftments/functions.py backup"
alias categories="docker exec adjuftments /home/Adjuftments/functions.py categories"
alias budgets="docker exec adjuftments /home/Adjuftments/functions.py budgets"
alias images="docker exec adjuftments /home/Adjuftments/functions.py images"
alias stocks="docker exec adjuftments /home/Adjuftments/functions.py stocks"
alias logs="docker logs adjuftments"
alias adjf='function _adjf(){ $1 ~/Documents/Python/Adjuftments; };_adjf'
alias dockerbash="docker exec -it adjuftments bin/bash"

# DOCKER
alias docker_purge="docker rm $(docker ps -a -q) && docker rmi $(docker images -q) --force"
alias dbash='function _dbash(){ docker exec -it $1 bin/bash; };_dbash'

# GIT
alias git-remove-untracked='git fetch --prune && git branch -r | awk "{print \$1}" | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk "{print \$1}" | xargs git branch -d'
alias check='function _check(){ git checkout $1; };_check'

# SYSTEM
alias hdtemp="sudo hddtemp /dev/sda"

# DIRECTORY ALIASES
alias movies='function _movies(){ $1 /media/juftin/NAS/Plex/Movies; };_movies'
alias tvshows='function _tvshows(){ $1 /media/juftin/NAS/Plex/TV\ Shows/; };_tvshows'

# SSH
alias ssh_logs='egrep "Failed|Failure" /var/log/auth.log'
