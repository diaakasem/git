express = require "express"
http    = require "http"
sys     = require "sys"
process = require "child_process"
app     = express()

app.configure ->
  app.set "port", process.env.PORT or 3333

gitUpdate = (project, cb)->
  process.exec "cd /dino/#{project}/ ; git pull ; cd -", cb


# for development purpose only ( Hg update )
app.post "/update/:repo", (req, res) ->
  repo = req.params.repo
  cb = (error, stdout, stderr) ->
    res.send stdout

  gitUpdate repo, cb

# #######################################
# Server Creation
# #######################################
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

