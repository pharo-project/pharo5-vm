initialization
computeEntryOffsets
	"Generate the entry code for a method to determine cmEntryOffset and cmNoCheckEntryOffset.  We
	 need cmNoCheckEntryOffset up front to be able to generate the map starting from cmNoCheckEntryOffset"
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	| sendMissCall |
	<var: 'sendMissCall' type: #'AbstractInstruction *'>
	self allocateOpcodes: 24 bytecodes: 0.
	methodOrBlockNumArgs := 0.
	sendMissCall := self compileAbort.
	self compileEntry.
	self computeMaximumSizes.
	self generateInstructionsAt: methodZoneBase + (self sizeof: CogMethod).
	cmEntryOffset := entry address - methodZoneBase.
	cmNoCheckEntryOffset := noCheckEntry address - methodZoneBase.
	missOffset := sendMissCall address + sendMissCall machineCodeSize - methodZoneBase.
	entryPointMask := objectMemory wordSize - 1.
	[(cmEntryOffset bitAnd: entryPointMask) = (cmNoCheckEntryOffset bitAnd: entryPointMask)] whileTrue:
		[entryPointMask := entryPointMask + entryPointMask + 1].
	entryPointMask >= (methodZone roundUpLength: 1) ifTrue:
		[self error: 'cannot differentiate checked and unchecked entry-points with current cog method alignment'].
	checkedEntryAlignment := cmEntryOffset bitAnd: entryPointMask.
	uncheckedEntryAlignment := cmNoCheckEntryOffset bitAnd: entryPointMask.
	self assert: checkedEntryAlignment ~= uncheckedEntryAlignment