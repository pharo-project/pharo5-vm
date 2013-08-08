initialize-release
run
   open := true.
   process ifNil:
         [process := [self processVisitors] newProcess.
         process priority: Processor userBackgroundPriority -1 ].
   process resume