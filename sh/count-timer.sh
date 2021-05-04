#!/bin/bash
# Set variables to your desired time.
hour=2
min=0
sec=0
       # begin hour while loop - while hour
       #variable is greater than or equal to 0 do minute loop
       while [ $hour -ge 0 ]; do
                # begin minute loop - while min variable
                #is greater than or equal to 0 do second loop
                while [ $min -ge 0 ]; do
                        # begin second loop - while sec variable is greater
                        # than or equal to 0 print time left
                        while [ $sec -ge 0 ]; do
                                # echo time on same line so it overwrites last                                             # line, makes it look like countdown
                                echo -ne "$hour:$min:$sec\33[0Kr"
                                # Decrease the sec variable by 1
                                #each iteration of loop to countdown
                                let "sec=sec-1"
                                # wait a second before removing a second
                                # from the countdown clock
                                sleep 1
                        # End second loop
                        done
                        # Set second timer back to 59 to start new minute
                        sec=59
                        # Decrease min variable by 1 to remove a
                        # minute off the countdown
                        let "min=min-1"
                # end minute loop
                done
                # Set minute timer back to 59 to start new hour
                min=59
                # decrease the hour by 1 to remove hour off the countdown
                let "hour=hour-1"
        # end hour loop
        done