process primitive support
signalExternalSemaphores
	"Signal all requested semaphores"
	| xArray xSize index sema |
	semaphoresUseBufferA := semaphoresUseBufferA not.
	xArray := self splObj: ExternalObjectsArray.
	xSize := self stSizeOf: xArray.
	semaphoresUseBufferA
		ifTrue: ["use opposite buffer during read"
			1 to: semaphoresToSignalCountB do: [:i | 
					index := semaphoresToSignalB at: i.
					index <= xSize
						ifTrue: [sema := self fetchPointer: index - 1 ofObject: xArray.
							"Note: semaphore indices are 1-based"
							(self fetchClassOf: sema) = (self splObj: ClassSemaphore)
								ifTrue: [self synchronousSignal: sema]]].
			semaphoresToSignalCountB := 0]
		ifFalse: [1 to: semaphoresToSignalCountA do: [:i | 
					index := semaphoresToSignalA at: i.
					index <= xSize
						ifTrue: [sema := self fetchPointer: index - 1 ofObject: xArray.
							"Note: semaphore indices are 1-based"
							(self fetchClassOf: sema) = (self splObj: ClassSemaphore)
								ifTrue: [self synchronousSignal: sema]]].
			semaphoresToSignalCountA := 0]