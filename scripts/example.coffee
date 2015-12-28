# Description:
#   Example scripts for you to examine and try out.
#
# Notes:
#   They are commented out by default, because most of them are pretty silly and
#   wouldn't be useful and amusing enough for day to day huboting.
#   Uncomment the ones you want to try and experiment with.
#
#   These are from the scripting documentation: https://github.com/github/hubot/blob/master/docs/scripting.md

require('date-utils')


module.exports = (robot) ->
    
   github = require("githubot")(robot)
   robot.respond /repo show (.*)$/i, (msg) ->
     repo = github.qualified_repo msg.match[1]
     base_url = process.env.HUBOT_GITHUB_API || 'https://api.github.com'
     url = "#{base_url}/repos/#{repo}/commits"
 
     github.get url, (commits) ->
       if commits.message
         msg.send "Achievement unlocked: [NEEDLE IN A HAYSTACK] repository #{commits.message}!"
       else if commits.length == 0
           msg.send "Achievement unlocked: [LIKE A BOSS] no commits found!"
       else
         msg.send "https://github.com/#{repo}"
         send = 5
         for c in commits
           if send
             d = new Date(Date.parse(c.commit.committer.date)).toFormat("DD/MM HH24:MI")
             msg.send "[#{d} -> #{c.commit.committer.name}] #{c.commit.message}"
             send -= 1


   robot.hear /badger/i, (res) ->
     res.send "Badgers? BADGERS? WE DON'T NEED NO STINKIN BADGERS"
  
   robot.respond /open the (.*) doors/i, (res) ->
     doorType = res.match[1]
     if doorType is "pod bay"
       res.reply "I'm afraid I can't let you do that."
     else
       res.reply "Opening #{doorType} doors"
  
   robot.hear /I like pie/i, (res) ->
     res.emote "makes a freshly baked pie"
  
   lulz = ['lol', 'rofl', 'lmao']
  
   robot.respond /lulz/i, (res) ->
     res.send res.random lulz
  
   robot.topic (res) ->
     res.send "#{res.message.text}? That's a Paddlin'"
  
  
   enterReplies = ['Hi', 'Target Acquired', 'Firing', 'Hello friend.', 'Gotcha', 'I see you']
   leaveReplies = ['Are you still there?', 'Target lost', 'Searching']
  
   robot.enter (res) ->
     res.send res.random enterReplies
   robot.leave (res) ->
     res.send res.random 
  
   process.env['HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING'] = 'Really to be honest how is a robot is supposed to know??'
   answer = process.env.HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING
  
   robot.respond /what is the answer to the ultimate question of life/, (res) ->
     unless answer?
       res.send "Missing HUBOT_ANSWER_TO_THE_ULTIMATE_QUESTION_OF_LIFE_THE_UNIVERSE_AND_EVERYTHING in environment: please set and try again"
       return
     res.send "#{answer}, but what is the question?"
  
   robot.respond /you are a little slow/, (res) ->
     setTimeout () ->
       res.send "Who you calling 'slow'?"
     , 60 * 1000
  
   annoyIntervalId = null
  
   robot.respond /annoy me/, (res) ->
     if annoyIntervalId
       res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
       return
  
     res.send "Hey, want to hear the most annoying sound in the world?"
     annoyIntervalId = setInterval () ->
       res.send "AAAAAAAAAAAEEEEEEEEEEEEEEEEEEEEEEEEIIIIIIIIHHHHHHHHHH"
     , 1000
  
   robot.respond /unannoy me/, (res) ->
     if annoyIntervalId
       res.send "GUYS, GUYS, GUYS!"
       clearInterval(annoyIntervalId)
       annoyIntervalId = null
     else
       res.send "Not annoying you right now, am I?"
  
  
   robot.router.post '/hubot/chatsecrets/:room', (req, res) ->
     room   = req.params.room
     data   = JSON.parse req.body.payload
     secret = data.secret
  
     robot.messageRoom room, "I have a secret: #{secret}"
  
     res.send 'OK'
  
   robot.error (err, res) ->
     robot.logger.error "DOES NOT COMPUTE"
  
     if res?
       res.reply "DOES NOT COMPUTE"
  
   robot.respond /have a soda/i, (res) ->
     # Get number of sodas had (coerced to a number).
     sodasHad = robot.brain.get('totalSodas') * 1 or 0
  
     if sodasHad > 4
       res.reply "I'm too fizzy.."
  
     else
       res.reply 'Sure!'
  
       robot.brain.set 'totalSodas', sodasHad+1
  