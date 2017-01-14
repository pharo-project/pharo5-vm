primitive generators
maybeCompileAllocFillerCheck
	"If allocCheckFiller is true, words in newSpace from freeStart to scavengeThreshold
	 are filled with their address, and after each call of a plugin primitive, the VM checks
	 that freeStart points to a word containing the value of freeStart.  This is a simple
	 check for primitives overwriting the ends of an object."
	| jmpOk |
	<var: #jmpOk type: #'AbstractInstruction *'>
	coInterpreter getCheckAllocFiller ifTrue:
		[self MoveAw: objectMemory freeStartAddress R: ClassReg.
		 self MoveMw: 0 r: ClassReg R: TempReg.
		 self CmpR: ClassReg R: TempReg.
		 jmpOk := self JumpZero: 0.
		 self MoveCq: PrimErrWritePastObject R: TempReg.
		 self MoveR: TempReg Aw: coInterpreter primFailCodeAddress.
		 jmpOk jmpTarget: self Label]