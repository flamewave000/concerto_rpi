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
    /bin/echo "Concerto Client Configuration Script"
    /bin/echo -n "Do you wish to proceed [y/n]?"
    read x
    case $x in
      y|Y)
        break
      ;;
      n|N)
        /bin/echo OK.
        exit
      ;;
      *)
        /bin/echo "Invalid command '$x'"
      ;;
    esac
done

#This command will install the XSettings and the Unclutter programs
/bin/echo "INSTALLING REQUIRED PROGRAMS"
sudo /usr/bin/apt-get -y --force-yes install x11-xserver-utils unclutter

#This copies the Concerto script to the home directory
/bin/echo "COPYING CRONJOB SCRIPT TO $HOME"
#get the Concerto server web address, wether it be an IP or URL
gettingip=true
while $gettingip;
do
    /bin/echo "Please enter the Concerto Servers URL/IP address"
    /bin/echo -n "(www.example.com/concerto OR 123.4.5.67):"
    read ip
    while true;
    do
        /bin/echo "You entered: $ip"
        /bin/echo -n "Is this correct [y/n]?"
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
            /bin/echo "Invalid command '$x'"
          ;;
        esac
    done
done
/bin/echo
while true;
do
    /bin/echo "Do you wish to setup a ShoutCast Playback?"
    /bin/echo -n "[y/n]? "
    read x
    case $x in
      y|Y)
		sudo /usr/bin/apt-get update
		sudo /usr/bin/apt-get -y --force-yes install alsa-utils
		res=`sudo cat /etc/modules | grep snd_bcm2835`
		if [ "$res" == "" ]; then
			sudo /bin/echo "snd_bcm2835" >> /etc/modules
		fi
		sudo /usr/bin/apt-get install -y --force-yes install mpd mpc
		sudo /etc/init.d/mpd stop
		sudo /bin/chmod -x /etc/init.d/mpd
		shoutcast=1
		#get the ShoutCast Radio server web address, wether it be an IP or URL
		gettingip=true
		while $gettingip;
		do
			/bin/echo "Please enter the ShoutCast Radio [URL/IP][:port] address"
			/bin/echo "(http://radio.example.com:8000/ OR http://123.4.5.67:8000/)"
			/bin/echo -n " >> "
			read radio
			while true;
			do
				/bin/echo "You entered: $radio"
				/bin/echo -n "Is this correct [y/n]?"
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
					/bin/echo "Invalid command '$x'"
				  ;;
				esac
			done
		done
		/bin/echo
		#Copy the radio script file header then inject the user's given ShoutCast radio server web address and then append the rest of the script
		/usr/bin/head -n 2 ./.shoutcast > $HOME/shoutcast-radio.sh
		/bin/echo 'shoutcast_radio_link="'$radio'"' >> $HOME/shoutcast-radio.sh
		/usr/bin/tail --lines=+3 ./.shoutcast >> $HOME/shoutcast-radio.sh
        break
      ;;
      n|N)
        /bin/echo OK.
        break
      ;;
      *)
        /bin/echo "Invalid command '$x'"
      ;;
    esac
done
#Copy the concerto script file header then inject the user's given Concerto server web address and then append the rest of the script
/usr/bin/head -n 4 ./.script > $HOME/digitalsignage.sh
/bin/echo 'ConcertoServerIP="'$ip'"' >> $HOME/digitalsignage.sh
/usr/bin/tail --lines=+5 ./.script >> $HOME/digitalsignage.sh

#This sets up a Cron job (Cron is a task scheduler) that will run the previous Concerto script every minute
/bin/echo "SETTING UP CONCERTO CRON JOB"
cp ./.crontab ./.tmp
/bin/echo "* * * * * export DISPLAY=:0 && /bin/bash $HOME/digitalsignage.sh" >> ./.tmp
if [ $shoutcast ]; then
	/bin/echo "@reboot   /bin/bash $HOME/shoutcast-radio.sh &> $HOME/shoutcast-radio.log" >> ./.tmp
fi
/usr/bin/crontab -u $USER ./.tmp
/bin/rm ./.tmp

/bin/echo "SETTING UP AUTO-LOGIN"
/bin/echo 'if [ "`/bin/ps -A | /bin/grep -o -E "startx"`" == "" ]; then' >> ~/.bashrc
/bin/echo "    startx" >> ~/.bashrc
/bin/echo "fi" >> ~/.bashrc
sudo /usr/bin/perl -pi -e 's/1:2345:respawn:\/sbin\/getty --noclear 38400 tty1/1:2345:respawn:\/bin\/login -f pi tty1<\/dev\/tty1 >\/dev\/tty1 2>\&1/g' /etc/inittab

#And we're done :)
echo "DONE."