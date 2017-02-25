compile abstract instructions
genGetClassObjectOf: instReg into: destReg scratchReg: scratchReg instRegIsReceiver: instRegIsReceiver
	"Fetch the instance's class into destReg.  If the instance is not the receiver and is forwarded, follow forwarding."
	| jumpIsImm jumpNotForwarded loop |
	<var: #jumpIsImm type: #'AbstractInstruction *'>
	<var: #jumpNotForwarded type: #'AbstractInstruction *'>
	<var: #loop type: #'AbstractInstruction *'>
	(instReg = destReg or: [instReg = scratchReg or: [destReg = scratchReg]]) ifTrue:
		[^BadRegisterSet].
	loop := cogit MoveR: instReg R: scratchReg.
	cogit AndCq: objectMemory tagMask R: scratchReg.
	jumpIsImm := cogit JumpNonZero: 0.
	self flag: #endianness.
	"Get least significant half of header word in destReg"
	cogit MoveMw: 0 r: instReg R: scratchReg.
	"mask off class index"
	cogit AndCq: objectMemory classIndexMask R: scratchReg.
	instRegIsReceiver ifFalse:
		["if it is forwarded..."
		cogit CmpCq: objectMemory isForwardedObjectClassIndexPun R: scratchReg.
		jumpNotForwarded := cogit JumpNonZero: 0.
		"...follow the forwarding pointer and loop to fetch its classIndex"
		cogit MoveMw: objectMemory baseHeaderSize r: instReg R: instReg.
		cogit Jump: loop.
		jumpNotForwarded jmpTarget: cogit Label].
	jumpIsImm jmpTarget:
	(cogit MoveR: scratchReg R: destReg).
	scratchReg = TempReg
		ifTrue:
			[cogit PushR: instReg.
			 self genGetClassObjectOfClassIndex: destReg into: instReg scratchReg: TempReg.
			 cogit MoveR: instReg R: destReg.
			 cogit PopR: instReg]
		ifFalse:
			[self genGetClassObjectOfClassIndex: destReg into: scratchReg scratchReg: TempReg.
			 cogit MoveR: scratchReg R: destReg].
	^0