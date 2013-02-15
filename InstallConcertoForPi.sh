#!/bin/bash
#    Concerto Client Configuration Script
#
#    Copyright (C) 2013  Andrew Fryer (flamewave000)
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

#This is just a simple menu asking the user if they wish to proceed with installing the Concerto scripts
while true;
do
    echo "Concerto Client Configuration Script"
    echo -n "Do you wish to proceed [y/n]?"
    read x
    case $x in
      y|Y)
        break
      ;;
      n|N)
        echo OK.
        exit
      ;;
      *)
        echo "Invalid command '$x'"
      ;;
    esac
done

#This command will install the XSettings and the Unclutter programs
echo "INSTALLING REQUIRED PROGRAMS"
sudo apt-get -y --force-yes install x11-xserver-utils unclutter

#This copies the Concerto script to the home directory
echo "COPYING CRONJOB SCRIPT TO $HOME"
#get the Concerto server web address, wether it be an IP or URL
gettingip=true
while $gettingip;
do
    echo "Please enter the Concerto Servers URL/IP address"
    echo -n "(www.example.com/concerto OR 123.4.5.67):"
    read ip
    while true;
    do
        echo "You entered: $ip"
        echo -n "Is this correct [y/n]?"
        read x
        case $x in
          y|Y)
            gettingip=false
            break
          ;;
          n|N)
            break
          ;;
          *)
            echo "Invalid command '$x'"
          ;;
        esac
    done
done
echo 
#Copy the file header then inject the user's given Concerto server web address and then append the rest of the script
head -n 4 ./.script > $HOME/digitalsignage.sh
echo 'ConcertoServerIP="'$ip'"' >> $HOME/digitalsignage.sh
tail --lines=+5 ./.script >> $HOME/digitalsignage.sh

#This sets up a Cron job (Cron is a task scheduler) that will run the previous Concerto script every minute
echo "SETTING UP CONCERTO CRON JOB"
cp ./.crontab ./.tmp
echo "* * * * * export DISPLAY=:0 && /bin/bash $HOME/digitalsignage.sh" >> ./.tmp
crontab -u $USER ./.tmp
rm ./.tmp

#And we're done :)
echo "DONE."