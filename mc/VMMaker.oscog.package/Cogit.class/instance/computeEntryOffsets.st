initialization
computeEntryOffsets
	"Generate the entry code for a method to determine cmEntryOffset and cmNoCheckEntryOffset.  We
	 need cmNoCheckEntryOffset up front to be able to generate the map starting from cmNoCheckEntryOffset"
	"stack allocate the various collections so that they
	 are effectively garbage collected on return."
	self allocateOpcodes: 20 bytecodes: 0.
	methodOrBlockNumArgs := 0.
	self compileAbort.
	self compileEntry.
	self computeMaximumSizes.
	self generateInstructionsAt: methodZoneBase + (self sizeof: CogMethod).
	cmEntryOffset := entry address - methodZoneBase.
	cmNoCheckEntryOffset := noCheckEntry address - methodZoneBase.
	self cppIf: NewspeakVM
		ifTrue: [cmDynSuperEntryOffset := dynSuperEntry address - methodZoneBase].
	missOffset := sendMissCall address + sendMissCall machineCodeSize - methodZoneBase.
	entryPointMask := BytesPerWord - 1.
	[self cppIf: NewspeakVM
		ifTrue: [(cmEntryOffset bitAnd: entryPointMask) = (cmNoCheckEntryOffset bitAnd: entryPointMask)
				or: [(cmEntryOffset bitAnd: entryPointMask) = (cmDynSuperEntryOffset bitAnd: entryPointMask)
				or: [(cmNoCheckEntryOffset bitAnd: entryPointMask) = (cmDynSuperEntryOffset bitAnd: entryPointMask)]]]
		ifFalse: [(cmEntryOffset bitAnd: entryPointMask) = (cmNoCheckEntryOffset bitAnd: entryPointMask)]] whileTrue:
		[entryPointMask := entryPointMask + entryPointMask + 1].
	entryPointMask >= (methodZone roundUpLength: 1) ifTrue:
		[self error: 'cannot differentiate checked and unchecked entry-points with current cog method alignment'].
	checkedEntryAlignment := cmEntryOffset bitAnd: entryPointMask.
	uncheckedEntryAlignment := cmNoCheckEntryOffset bitAnd: entryPointMask.
	self assert: checkedEntryAlignment ~= uncheckedEntryAlignment.
	self cppIf: NewspeakVM
		ifTrue:
			[cmDynSuperEntryOffset := dynSuperEntry address - methodZoneBase.
			 dynSuperEntryAlignment := cmDynSuperEntryOffset bitAnd: entryPointMask.
			self assert: dynSuperEntryAlignment ~= checkedEntryAlignment.
			self assert: dynSuperEntryAlignment ~= uncheckedEntryAlignment]