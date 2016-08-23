compaction
planCompaction
	"Some methods have been freed.  Compute how much each survivor needs to
	 move during the ensuing compaction and record it in the objectHeader field.

	 For Sista, where we want PICs to last so they can be observed, we need to keep PICs unless
	 they are definitely unused.  So we need to identify unused PICs.  So in planCompact, zero the
	 usage counts of all PICs, saving the actual usage count in blockEntryOffset.  Then in
	 relocateMethodsPreCompaction (actually in relocateIfCallOrMethodReference:mcpc:delta:)
	 restore the usage counts of used PICs.  Finally in compactCompiledCode, clear the blockEntryOffset
	 of the unused PICs; they will then have a zero count and be reclaimed in the next code compaction."
	| delta cogMethod |
	<var: #cogMethod type: #'CogMethod *'>
	delta := 0.
	cogMethod := cogit cCoerceSimple: baseAddress to: #'CogMethod *'.
	[cogMethod asUnsignedInteger < mzFreeStart] whileTrue:
		[cogMethod cmType = CMFree
			ifTrue: [delta := delta - cogMethod blockSize]
			ifFalse:
				[self assert: (cogit cogMethodDoesntLookKosher: cogMethod) = 0.
				 cogMethod objectHeader: delta.
				 SistaVM ifTrue:
					[self savePICUsageCount: cogMethod]].
		 cogMethod := self methodAfter: cogMethod]