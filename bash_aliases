alias agupd='sudo apt update && sudo apt list --upgradable'
alias agupg='sudo apt upgrade'
alias agar='sudo apt autoremove'
alias ctop='docker run --rm -ti --name=ctop --volume /var/run/docker.sock:/var/run/docker.sock:ro quay.io/vektorlab/ctop:latest -s name'