getLinuxDistro () {
    echo $(cat /etc/os-release | grep ID | head -n1 | cut -d '=' -f2 | tr '[:upper:]' '[:lower:]') 
}
