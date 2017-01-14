process primitive support
signalSemaphoreWithIndex: index
	"Record the given semaphore index in the double buffer semaphores array to be signaled at the next convenient moment. Force a real interrupt check as soon as possible."

	index <= 0 ifTrue: [^ nil].  "bad index; ignore it"

	semaphoresUseBufferA
		ifTrue: [semaphoresToSignalCountA < SemaphoresToSignalSize
			ifTrue: [ semaphoresToSignalCountA := semaphoresToSignalCountA + 1.
				semaphoresToSignalA at: semaphoresToSignalCountA put: index]]
		ifFalse: [semaphoresToSignalCountB < SemaphoresToSignalSize
			ifTrue: [ semaphoresToSignalCountB := semaphoresToSignalCountB + 1.
				semaphoresToSignalB at: semaphoresToSignalCountB put: index]].
	self forceInterruptCheck
