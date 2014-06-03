compaction
planCompaction
	"Some metods have been freed.  Compute how much each survivor needs to
	 move during the ensuing compaction and record it in the objectHeader field."
	| delta cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	delta := 0.
	cogMethod := coInterpreter cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod asUnsignedInteger < mzFreeStart] whileTrue:
		[cogMethod cmType = CMFree
			ifTrue: [delta := delta - cogMethod blockSize]
			ifFalse:
				[self assert: (cogit cogMethodDoesntLookKosher: cogMethod) = 0.
				 cogMethod objectHeader: delta].
		 cogMethod := self methodAfter: cogMethod]