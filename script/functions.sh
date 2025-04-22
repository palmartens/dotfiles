getLinuxDistro () {
    echo $(cat /etc/os-release | grep -v VERSION_ID | grep ID | head -n1 | cut -d '=' -f2 | tr '[:upper:]' '[:lower:]' | tr -d '"' | tr -d "'") 
}

isInstalled() {
    local command=$1

    if command -v "$command" > /dev/null
    then
      echo "$command already installed, doing nothing."
      exit 0
    fi
}