# mecacontrol

Control Metz TV using MecaControl (via network).

python and bash are required.

Example:
Select next channel:
./mecacontrol_send.sh 'Metz-TV' '46'

'Metz-TV' is the name configured on the TV.
'46' is the key code for selecting next channel.

The key codes are:
46 channel+
47 channel-
27 volume up
28 volume down
1-10 buttons 0-9
39 OK
23 up
24 down
25 left
26 right
43 play
41 backwards
42 forwards
44 stop
33 back
40 exit
35 sound off
35 sound on
36 TEXT
37 EPG
38 MENU
18 blue
19 yellow
20 black/grey
21 green
22 red
64 jump to start
65 jump to end
45 record
34 pause
255 16 HDMI 1
255 17 HDMI 2
255 18 HDMI 3
255 19 HDMI 4
255 20 Euro
255 21 Cinch AV
255 22 Cinch Audio
255 0 TV modus
51 power off
52 power on
