accessing
at: index ifAbsent: aBlock
	"This is a simulation-time-only convenience..."
	^object at: index + offset + 1 ifAbsent: aBlock