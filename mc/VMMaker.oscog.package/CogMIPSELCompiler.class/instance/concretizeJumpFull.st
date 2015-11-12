generate machine code - concretize
concretizeJumpFull
	| jumpTarget |
	<var: #jumpTarget type: #'AbstractInstruction *'>
	jumpTarget := self longJumpTargetAddress.
	self machineCodeAt: 0 put: (self luiR: TargetReg C: (self high16BitsOf: jumpTarget)).
	self machineCodeAt: 4 put: (self oriR: TargetReg R: ZR C: (self low16BitsOf: jumpTarget)).	
	self machineCodeAt: 8 put: (self jR: TargetReg).
	self machineCodeAt: 12 put: self nop. "Delay slot"
	^machineCodeSize := 16