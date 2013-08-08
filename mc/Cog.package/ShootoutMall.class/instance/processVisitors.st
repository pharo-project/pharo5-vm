private
processVisitors
   [open] whileTrue:
         [1 to: maxRendezvous
            do:
               [:x |
               | first second |
               first := queue next.
               second := queue next.
               self setPartnersOn: first and: second.
               first signal.
               second signal].
         [queue isEmpty] whileFalse: [queue next signal]].
   process terminate.
   process := nil