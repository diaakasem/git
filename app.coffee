express = require "express"
http    = require "http"
sys     = require "sys"
process = require "child_process"
app     = express()

app.configure ->
  app.set "port", 3333

gitUpdate = (project, cb)->
  command = "cd #{project}; git pull ; npm install; bower install; cd -"
  console.log "Executing #{command}"
  process.exec command, cb


# for development purpose only ( Hg update )
app.post "/update/:csvpath", (req, res) ->
  csvpath = req.params.csvpath
  console.log csvpath
  cb = (error, stdout, stderr) ->
    res.send stdout

  path = csvpath.replace /,/g, '/'

  gitUpdate path, cb

# #######################################
# Server Creation
# #######################################
http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")

