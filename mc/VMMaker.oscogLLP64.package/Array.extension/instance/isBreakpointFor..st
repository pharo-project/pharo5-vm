*VMMaker-interpreter simulator
isBreakpointFor: address
	1 to: self size do:
		[:i| (self at: i) = address ifTrue: [^true]].
	^false