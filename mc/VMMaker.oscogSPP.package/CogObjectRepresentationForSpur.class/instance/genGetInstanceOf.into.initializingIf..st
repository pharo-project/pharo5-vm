bytecode generator support
genGetInstanceOf: classObj into: destReg initializingIf: initializeInstance
	"Create an instance of classObj and assign it to destReg, initializing the instance
	 if initializeInstance is true with nil or 0 as appropriate This is for inline primitives.
	 Assume there is sufficient space in new space to complete the operation.
	 Answer zero on success."
	| classIndex classFormat header slots |
	((objectMemory isNonImmediate: classObj)
	 and: [(coInterpreter objCouldBeClassObj: classObj)
	 and: [(classIndex := objectMemory rawHashBitsOf: classObj) ~= 0
	 and: [(objectMemory isFixedSizePointerFormat: (objectMemory instSpecOfClassFormat: (classFormat := objectMemory formatOfClass: classObj)))
	 and: [(slots := objectMemory fixedFieldsOfClassFormat: classFormat) < objectMemory numSlotsMask]]]]) ifFalse:
		[^UnimplementedOperation].

	header := objectMemory
					headerForSlots: slots
					format: (objectMemory instSpecOfClassFormat: classFormat)
					classIndex: classIndex.

	cogit MoveAw: objectMemory freeStartAddress R: destReg.
	self genStoreHeader: header intoNewInstance: destReg using: TempReg.
	cogit
		LoadEffectiveAddressMw: (objectMemory smallObjectBytesForSlots: slots) r: destReg R: TempReg;
		MoveR: TempReg Aw: objectMemory freeStartAddress.
	(initializeInstance and: [slots > 0]) ifTrue:
		[cogit genMoveConstant: objectMemory nilObject R: TempReg.
		 0 to: slots - 1 do:
			[:i| cogit MoveR: TempReg
					Mw: i * objectMemory wordSize + objectMemory baseHeaderSize
					r: destReg]].
	^0