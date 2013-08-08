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
	[next := dest - BytesPerWord.
	 next >= youngReferrers
	 and: [(coInterpreter cCoerceSimple: (objectMemory longAt: next) to: #'CogMethod *') cmRefersToYoung]] whileTrue:
		[dest := next].
	self assert: dest >= youngReferrers.
	source := dest - BytesPerWord.
	[source >= youngReferrers] whileTrue:
		[(coInterpreter cCoerceSimple: (objectMemory longAt: source) to: #'CogMethod *') cmRefersToYoung ifTrue:
			[self assert: source < (dest - BytesPerWord).
			 objectMemory longAt: (dest := dest - BytesPerWord) put: (objectMemory longAt: source)].
		 source := source - BytesPerWord].
	youngReferrers := dest.
	self assert: self kosherYoungReferrers