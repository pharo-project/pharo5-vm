primitive generators
genPrimitiveClass
	"Primitive class must be variadic for objectClass:"
	| reg |
	methodOrBlockNumArgs > 0
		ifTrue:
			[methodOrBlockNumArgs > 1 ifTrue:
				[^self compileFallbackToInterpreterPrimitive: 0].
			 reg := Arg0Reg]
		ifFalse:
			[reg := ReceiverResultReg].
	(objectRepresentation
			genGetClassObjectOf: reg
			into: ReceiverResultReg
			scratchReg: TempReg
			instRegIsReceiver: methodOrBlockNumArgs = 0) = BadRegisterSet ifTrue:
		[objectRepresentation
			genGetClassObjectOf: reg
			into: ClassReg
			scratchReg: TempReg
			instRegIsReceiver: methodOrBlockNumArgs = 0.
		 self MoveR: ClassReg R: ReceiverResultReg].
	self RetN: 0.
	^0