# Description:
#   Automatically notify's channel on slack & then private messages to assignee.
#
# Dependencies:
#   "githubot": "0.4.x"
#
# Configuration:
#   HUBOT_GITHUB_TOKEN 
#   HUBOT_GITHUB_USER
#   HUBOT_GITHUB_REPO
#   HUBOT_GITHUB_API - Optional
#
# Commands:
#   [user/repository] (.*) 
#
# Notes:
#   Setup Slack integration with GITHUB followed by the repositories you would like to watch.
#   #[user/repository] Issue created by author (assigned to assignee) GETS Translated into Objects. Assigned to is optional.
#
# Author:
#   jaeko44/Jonathan Philipos for use by VirtKick


module.exports = (robot)->

    robot.hear /\[(.*)\/(.*)\]((.*)+)/i, (res) ->
        console.log 'Step 1: Achieved'
        GithubAuthor = res.match[1]
        GithubRepository = res.match[2]
        Rest = res.match[3]
        AllString = res.match[0]
        str =  AllString
        #DEFINE All USERNAMES 
        Slack_Usernames = [
          'pavilion'
          'jon_ph'
          'jaeko44'
        ]
        arrayLength = Slack_Usernames.length
        i = 0
        console.log "String getting checked: #{str}"
        while i < arrayLength
            #Do something
            user = Slack_Usernames[i]
            n = str.indexOf(user)
            if n >= 0
                userStr = str.slice(n)
                console.log "Expected (Github) -> #{res.envelope.user.name} - Found username = #{user}"
                try
                    robot.send {room: user}, str #Sends STR -> Res.Envelope.User.Nam  
                catch error
                    console.log "Cannot find username = #{user}, received the following error #{error}"
            else 
                console.log "Could not find #{user}"
            #Finished - Loop over and find another user mentioned.
            i++
