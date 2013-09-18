express     = require "express"
http        = require "http"
app         = express()

app.configure ->
  app.set "port", process.env.PORT or 3333

# for development purpose only ( Hg update )
app.post "/update/:repo", (req, res) ->
  repo = req.params.repo
  puts = (error, stdout, stderr) ->
    res.send stdout
  sys = require "sys"
  exec = require("child_process").exec
  exec "cd /dino/#{repo}/ ; git pull ; cd -", puts
  #
# #######################################
# Server Creation
# #######################################
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

