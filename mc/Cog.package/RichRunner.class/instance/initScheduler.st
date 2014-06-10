private
initScheduler
    queuePacketCount := holdCount := 0.
    taskTable := Array new: 6.
    taskList := nil