primitive support
windowIsClosing
	self threadManager ifNotNil:
		[:threadManager|
		threadManager guiProcess ~= Processor activeProcess ifTrue:
			[threadManager guiProcess
				signalException:
					(Notification new tag: #evaluateQuit; yourself).
			Processor terminateActive]].
	quitBlock ifNotNil:
		[:effectiveQuitBlock|
		quitBlock := nil. "stop recursion on explicit window close."
		[effectiveQuitBlock value]
			on: BlockCannotReturn
			do: [:ex|]]	"Cause return from #test, et al"