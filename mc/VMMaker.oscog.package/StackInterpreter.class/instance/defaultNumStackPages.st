initialization
defaultNumStackPages
	"Return the default number of stack pages allocate at startup.
	 This V3 default suits Qwaq Forums (specifically general rendering).
	 The Spur default reflects tuning for GC performance ast Cadence.
	 It is probably a bit high for normal use but QF is profligate with processes.
	 The actual value can be set via vmParameterAt: and/or a preference in the ini file."
	<inline: false>
	^objectMemory hasSpurMemoryManagerAPI
		ifTrue: [50]
		ifFalse: [160]