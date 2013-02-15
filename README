                         ┌────────────────────────────┐
                         │  Concerto for Raspberry Pi │
                         │      By: Andrew Fryer      │
                         │      January 18, 2013      │
╔════════════════════════╧════════════════════════════╧══════════════════════════╗
║ 1. Introduction ────────────────────────────────────────────────────── Line 24 ║
║                                                                                ║
║ 2. Setting up the Raspberry Pi ─────────────────────────────────────── Line 35 ║
║   a. Required materials and software                                           ║
║   b. Installing the OS                                                         ║
║                                                                                ║
║ 3. Setting up Concerto ─────────────────────────────────────────────── Line 55 ║
║   a. Automatic Installation                                                    ║
║         I. Required Files                                                      ║
║        II. Installing Concerto for Pi                                          ║
║   b. Manual Installation                                                       ║
║         I. Required Software                                                   ║
║        II. Installing the Script                                               ║
║       III. Setting up the Cron Job                                             ║
║                                                                                ║
║ 4. Changing the Server URL/IP Address ─────────────────────────────── Line 109 ║
╚════════════════════════════════════════════════════════════════════════════════╝
╔════════════════════════════════════════════════════════════════════════════════╗
║ 1. Introduction                                                                ║
║                                                                                ║
║    This document explains how to properly set up a Raspberry Pi mini computer  ║
║    to act as a Concerto client machine. The basic goal of this is to have a    ║
║    device that, upon starting, will automatically start a Midori browser in    ║
║    fullscreen and send it to the Concerto web page containing the device's     ║
║    specific contents. We also wish to hide the mouse cursor and prevent the    ║
║    device from going to sleep due to inactivity. Also, if the Midori browser   ║
║    were to crash or close, we want to automatically restart the browser as     ║
║    soon as possible.                                                           ║
╟────────────────────────────────────────────────────────────────────────────────╢
║ 2. Setting up the Raspberry Pi                                                 ║
║                                                                                ║
║    a. Required materials and software                                          ║
║        - Raspberry Pi Model B and a 5V-1A MicroUSB Power Supply                ║
║        - Standard SD card 4GB or more                                          ╨
║        - Raspbery Pi's Wheezy Linux Distro OS (http://downloads.raspberrypi.org/download.php?file=/images/raspbian/2012-12-16-wheezy-raspbian/2012-12-16-wheezy-raspbian.zip)
║        - Win32 Imager (https://launchpad.net/win32-image-writer/+download)     ╥
║                                                                                ║
║    b. Installing the OS                                                        ║
║        - Begin by first formatting the SD card.This can be either a full       ║
║          format or a quick format. If the SD is already formatted then you     ║
║          don't need to bother.                                                 ║
║        - Next run the Win32 Disk Imager program with Adminstrative Privileges. ║
║          Select the drive letter for the SD card and open the Wheezy .img      ║
║          file. Once that's done click the [Write] button.                      ║
║        - Once the program finishes your SD card will now contain the Wheezy    ║
║          OS. The next thing is to test it to make sure it works.               ║
║        - Place the card in the Raspberry Pi and start it up. If it works       ║
║          great! If not, try reinstalling the OS.                               ║
╟────────────────────────────────────────────────────────────────────────────────╢
║ 3. Setting up Concerto                                                         ║
║    a. Automatic Installation                                                   ║
║       I. Required Files                                                        ║
║          These files should be found in the ConcertoForPi.zip file.            ║
║           - InstallConcertoForPi.sh                                            ║
║           - .crontab                                                           ║
║           - .script                                                            ║
║      II. Installing Concerto for Pi                                            ║
║           - Extract the files onto the Raspberry Pi. You can do this by        ║
║             either downloading the ConcertoForPi.zip from a network location   ║
║             or by transferring it with a USB flash drive.                      ║
║           - Once extracted, open a command prompt (linux terminal)             ║
║           - Navigate to the extracted files using the cd command               ║
║           - Type the following command:                                        ║
║                 bash InstallConcertoForPi.sh                                   ║
║           - Follow the on-screen instructions and your done! (your mouse       ║
║             should disappear when ever it's not moving. The Raspberry Pi       ║
║             should not turn off while inactive and the Midori browser          ║
║             should begin to automatically start.)                              ║
║                                                                                ║
║    b. Manual Installation                                                      ║
║       I. Required Software                                                     ║
║          This software must be installed onto the Raspberry Pi                 ║
║           - x11-xserver-utils                                                  ║
║           - unclutter                                                          ║
║          To install the software, open a command prompt and enter the          ║
║          following command:                                                    ║
║              sudo apt-get install x11-xserver-utils unclutter                  ║
║      II. Installing the Script                                                 ║
║          For this you will need the .script file. This script is what          ║
║          automates opening the Midori browser to the Concerto web page and     ║
║          making sure the computer does not fall asleep.                        ║
║           - First copy the file to the home folder. If you're not sure where   ║
║             that is, enter the following into a terminal: echo $HOME           ║
║           - Rename the file to "digitalsignage.sh"                             ║
║           - Next, open the file in a text editor and just after the line       ║
║             'LOG="./digitalsignage.log"' add the following on its own line:    ║
║                ConcertoServerIP=""                                             ║
║           - Fill in the "" with either the web URL or IP address of the        ║
║             Concerto server.                                                   ║
║     III. Setting up the Cron Job                                               ║
║           - Open a terminal and enter the following command:                   ║
║                 crontab -eu $USER                                              ║
║           - You should now see a command line text editor. Scroll down to the  ║
║             bottom of the file and add the following line (include every       ║
║             character including the *s):                                       ║
║               * * * * * export DISPLAY=:0 && /bin/bash $HOME/digitalsignage.sh ║
║           - Replace the $HOME portion with the direct path to the              ║
║             digitalsignage.sh file. ie. /home/user/digitalsignage.sh           ║
║           - Once done, save the document and close. If the editor does not     ║
║             show instructions on how to do so it is most likely the vim        ║
║             editor. To exit hit [Esc] and then enter ':x' and hit enter. That  ║
║             should save and close the document.                                ║
╟────────────────────────────────────────────────────────────────────────────────╢
║ 4. Changing the Server URL/IP Address                                          ║
║    Changing the server URL/IP Address is fairly simple to do.                  ║
║    - First navigate to the digitalsignage.sh file is located. It should be the ║
║      user's home folder which can be found by entering the following in a      ║
║      terminal: echo $HOME                                                      ║
║    - Open the digitalsignage.sh file in a text editor.                         ║
║    - Locate the line that starts with 'ConcertoServerIP='                      ║
║    - Inside the "" on that line is where the Concerto Server URL/IP Address    ║
║       is stored.                                                               ║
║    - Change it to the new address and save the file.                           ║
╚════════════════════════════════════════════════════════════════════════════════╝
