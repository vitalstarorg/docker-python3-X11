#!/bin/bash
/usr/local/bin/start-notebook.sh --NotebookApp.token='' > ~/notebook.log 2>&1 &
  # since it is for dev and running local, so we disable Jyputer to ask for token
#tail -f  ~/notebook.log | sed -n '/^ .* or \(http:\/\/127.0.0.1.*\)/ q'
#cat ~/notebook.log | sed -n 's/^ .* or \(http:\/\/127.0.0.1.*\)/\1/p'
