bytecode generator support
deassignRegisterForTempVar: targetEntry in: mergeSimStack
	"If merging a non-temp with a temp that has a live register we can assign
	 to the register, but must unassign the register from the temp, otherwise
	 the temp will acquire the merged value without an assignment.  The targetEntry
	 must also be transmogrified into an SSRegister entry."
	<var: #targetEntry type: #'SimStackEntry *'>
	<var: #duplicateEntry type: #'SimStackEntry *'>
	<var: #mergeSimStack type: #'SimStackEntry *'>
	<inline: true>
	| reg |
	reg := targetEntry liveRegister.
	self assert: (reg ~= NoReg and: [targetEntry type = SSConstant or: [targetEntry isFrameTempVar]]).
	targetEntry type = SSConstant
		ifTrue:
			[simStackPtr to: 0 by: -1 do:
				[:j| | duplicateEntry |
				 duplicateEntry := self simStack: mergeSimStack at: j.
				 (duplicateEntry registerOrNone = reg
				  and: [duplicateEntry type = SSBaseOffset or: [duplicateEntry type = SSSpill]]) ifTrue:
					[duplicateEntry liveRegister: NoReg]]]
		ifFalse:
			[simStackPtr to: 0 by: -1 do:
				[:j| | duplicateEntry |
				 duplicateEntry := self simStack: mergeSimStack at: j.
				 (targetEntry isSameEntryAs: duplicateEntry) ifTrue:
					[j < methodOrBlockNumTemps
						ifTrue: [duplicateEntry liveRegister: NoReg]
						ifFalse: [duplicateEntry type: SSRegister; register: reg]]]].
	targetEntry
		type: SSRegister;
		register: reg