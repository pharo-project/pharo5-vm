young referers
pruneYoungReferrers
	| source dest next |
	<var: #source type: #usqInt>
	<var: #dest type: #usqInt>
	<var: #next type: #usqInt>
	<inline: false>

	self assert: youngReferrers <= limitAddress.
	youngReferrers = limitAddress ifTrue:
		[^nil].
	dest := limitAddress.
	[next := dest - objectMemory wordSize.
	 next >= youngReferrers
	 and: [(coInterpreter cCoerceSimple: (objectMemory longAt: next) to: #'CogMethod *') cmRefersToYoung]] whileTrue:
		[dest := next].
	self assert: dest >= youngReferrers.
	source := dest - objectMemory wordSize.
	[source >= youngReferrers] whileTrue:
		[(coInterpreter cCoerceSimple: (objectMemory longAt: source) to: #'CogMethod *') cmRefersToYoung ifTrue:
			[self assert: source < (dest - objectMemory wordSize).
			 objectMemory longAt: (dest := dest - objectMemory wordSize) put: (objectMemory longAt: source)].
		 source := source - objectMemory wordSize].
	youngReferrers := dest.
	self assert: self kosherYoungReferrers