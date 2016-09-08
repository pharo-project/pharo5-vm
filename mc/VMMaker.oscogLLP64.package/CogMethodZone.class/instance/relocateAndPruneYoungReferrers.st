young referers
relocateAndPruneYoungReferrers
	| source dest next cogMethod |
	<var: #source type: #usqInt>
	<var: #dest type: #usqInt>
	<var: #next type: #usqInt>
	<var: #cogMethod type: #'CogMethod *'>
	<inline: false>

	self assert: youngReferrers <= limitAddress.
	youngReferrers = limitAddress ifTrue:
		[^nil].
	dest := limitAddress.
	[next := dest - objectMemory wordSize.
	 next >= youngReferrers
	 and: [(cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: next) to: #'CogMethod *') cmType ~= CMFree
	 and: [cogMethod cmRefersToYoung]]] whileTrue:
		[cogMethod objectHeader ~= 0 ifTrue:
			[coInterpreter longAt: next put: cogMethod asInteger + cogMethod objectHeader].
		 dest := next].
	self assert: dest >= youngReferrers.
	source := dest - objectMemory wordSize.
	[source >= youngReferrers] whileTrue:
		[cogMethod := coInterpreter cCoerceSimple: (objectMemory longAt: source) to: #'CogMethod *'.
		 (cogMethod cmType ~= CMFree
		  and: [cogMethod cmRefersToYoung]) ifTrue:
			[self assert: source < (dest - objectMemory wordSize).
			 cogMethod objectHeader ~= 0 ifTrue:
				[cogMethod := coInterpreter
									cCoerceSimple: cogMethod asInteger + cogMethod objectHeader asInteger
									to: #'CogMethod *'].
			 objectMemory longAt: (dest := dest - objectMemory wordSize) put: cogMethod asInteger].
		 source := source - objectMemory wordSize].
	youngReferrers := dest.
	"this assert must be deferred until after compaction.  See the end of compactCogCompiledCode"
	"self assert: self kosherYoungReferrers"