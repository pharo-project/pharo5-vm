primitive support
ioExit
	self threadManager ifNotNil:
		[:threadManager|
		threadManager guiProcess ~= Processor activeProcess ifTrue:
			[threadManager guiProcess
				signalException:
					(Notification new tag: #evaluateQuit; yourself).
			Processor terminateActive]].
	quitBlock value  "Cause return from #test"