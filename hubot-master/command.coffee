#command bot 

module.exports = (robot) ->

  robot.respond /hi/i, (res) ->
    res.send res.random ['su 6', 'Khem cho', 'hiii bot']
  
  robot.hear /(party)( me )?(.*)/i, (msg)->
    name = msg.match[3].trim()
    if name.length == 0
      msg.send("Aaaje toh party joie.")
    else
      msg.send(greeting(name))
  
  robot.hear /^congrats$/i, (res) ->
    res.send res.random ['Party...', 'Aaaje toh party joie']

  robot.hear /^congratulation$/i, (res) ->
    res.send res.random ['Party...', 'Aaaje toh party joie']

  robot.hear /^congratulations$/i, (res) ->
    res.send res.random ['Party...', 'Aaaje toh party joie']
  
  robot.hear /welcome( me)?(.*)/i, (msg) ->
    msg
      .http("http://cowsay.morecode.org/say")
      .query(format: 'text', message: msg.match[2])
      .get() (err, res, body) ->
       msg.send body
  
greeting = (name) ->
  greetings[(Math.random() * greetings.length) >> 0].replace(/{name}/, name);

greetings = [
  "{name} - Party...",
  "{name} - Aaaje toh party joie."
]

