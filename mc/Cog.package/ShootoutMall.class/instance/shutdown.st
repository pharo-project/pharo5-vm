private
shutdown
   [queue isEmpty] whileFalse: [queue next signal].
   process terminate.
   process := nil