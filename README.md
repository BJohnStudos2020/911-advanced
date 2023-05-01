## B.John Studios Advanced 911 Script ##

Youtube Video - `https://youtu.be/9Qnyz2egqrE`


`INFO and commands` 
This is a Advanced FiveM 911 script that allows for leo / dispatch to go on duty and receive 911 calls and caller proximity, which is ace perm restircted

- /OnDuty [LEO / Dispatch]          `If users has ace perms then this user will go on duty and will receive 911 calls`
- /OffDuty                          `If users is OnDuty then that user will go OffDuty`
- /911 [message]                    `Will send a 911 call to the leo with the message provided, location and caller name`   

    ## If there is no LEO on the server no one can send a 911 call in   ##

    ## If there is a  Dispatcher on then the dispatcher will receive the 911 call only ##

    ## If there is no Dispatch on then all LEO OnDuty will receive the 911 call ##


## [Installation] ##

### Add These to you server.cfg these need to be in for the script to work ###

ensure BJS-911-Advanced

add_ace group.leo group.bjsleo allow
add_ace group.leo command.bjsleo allow


##  [Config] ##

Config = {
    prefix911 = "^4[911] ^3",
    prefixduty = "^4[BJS-Duty] ^3",
    blip_remove_time = 180000                                   `This is the time in millerseconds that is will take for the 911 blip to go away`
}

## Postal Resources by BlockBa5her
Postals Link - https://forum.cfx.re/t/release-nearest-postal-script/293511

## If you have any issues or inquires please join our discord bellow and create a ticket ##

https://discord.gg/nV9XPh9
