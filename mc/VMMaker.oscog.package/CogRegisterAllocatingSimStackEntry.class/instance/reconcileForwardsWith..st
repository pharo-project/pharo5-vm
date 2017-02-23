compile abstract instructions
reconcileForwardsWith: targetEntry
	"Make the state of the receiver, a stack entry at the end of a basic block,
	 the same as the corresponding simStackEntry at the target of a preceding
	 jump to the beginning of the next basic block.  Make sure targetEntry
	 reflects the state of the merged simStack; it will be installed as the current
	 entry by restoreSimStackAtMergePoint: in mergeWithFixupIfRequired:.

	 Answer if the liveRegister for the targetEntry (if any) should be deassigned;
	 this is because if merging a non-temp with a temp that has a live register we
	 can assign to the register, but must unassign the register from the temp,
	 otherwise the temp will acquire the merged value without an assignment."
	<var: #targetEntry type: #'SimStackEntry *'>
	| targetReg |
	(targetReg := targetEntry registerOrNone) = NoReg ifTrue:
		[| reg |
		 self assert: targetEntry spilled.
		 (self isSameEntryAs: targetEntry) ifTrue:
			[self assert: spilled.
			 ^false].
		 (reg := self registerOrNone) = NoReg ifTrue: [reg := TempReg].
		 self storeToReg: reg.
		 spilled
			ifTrue: [cogit MoveR: reg Mw: targetEntry offset r: targetEntry register]
			ifFalse: [cogit PushR: reg].
		 ^false].
	liveRegister ~= NoReg ifTrue:
		[liveRegister ~= targetReg ifTrue:
			[cogit MoveR: liveRegister R: targetReg].
		 (spilled and: [targetEntry spilled not]) ifTrue:
			[cogit AddCq: objectRepresentation wordSize R: SPReg].
		 ^false].
	spilled
		ifTrue:
			[targetEntry spilled ifFalse:
				[cogit PopR: targetReg. "KISS; generate the least number of instructions..."
				 ^false]]
		ifFalse:
			[targetEntry spilled ifTrue:
				[cogit SubCq: objectRepresentation wordSize R: SPReg]].
	type caseOf: {
		[SSBaseOffset]	-> [cogit MoveMw: offset r: register R: targetReg].
		[SSSpill]		-> [cogit MoveMw: offset r: register R: targetReg].
		[SSConstant]	-> [cogit genMoveConstant: constant R: targetReg].
		[SSRegister]	-> [register ~= targetReg ifTrue:
								[cogit MoveR: register R: targetReg]] }.
	(targetEntry type = SSConstant
	 and: [type ~= SSConstant or: [constant ~= targetEntry constant]]) ifTrue:
		[targetEntry
			register: targetReg;
			type: SSRegister].
	"If merging a constant with a constant assigned to a register, then the register must be deassigned from any temps."
	^targetEntry type = SSConstant
	"If merging a non-temp with a temp that has a live register we can assign
	 to the register, but must unassign the register from the temp, otherwise
	 the temp will acquire the merged value without an assignment."
	 or: [targetEntry isFrameTempVar and: [(self isSameEntryAs: targetEntry) not]]