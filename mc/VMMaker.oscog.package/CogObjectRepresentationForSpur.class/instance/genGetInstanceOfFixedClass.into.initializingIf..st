bytecode generator support
genGetInstanceOfFixedClass: classObj into: destReg initializingIf: initializeInstance
	"Create an instance of classObj and assign it to destReg, initializing the instance
	 if initializeInstance is true with nil or 0 as appropriate This is for inline primitives.
	 Assume there is sufficient space in new space to complete the operation.
	 Answer zero on success."
	| classIndex classFormat header slots branch constReg inst loop delta loopCount slotsPerIteration |
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
	(initializeInstance and: [slots > 0]) ifFalse:
		[^0].
	slots <= (slotsPerIteration := 8) ifTrue: "slotsPerIteration must be a power of two. see bitAnd: below"
		[cogit genMoveConstant: objectMemory nilObject R: TempReg.
		 0 to: slots - 1 do:
			[:i| cogit MoveR: TempReg
					Mw: i * objectMemory wordSize + objectMemory baseHeaderSize
					r: destReg].
		^0].
	constReg := cogit allocateRegNotConflictingWith: destReg.
	cogit genMoveConstant: objectMemory nilObject R: constReg.
	
	slots \\ slotsPerIteration ~= 0
		ifTrue:
			[delta := objectMemory baseHeaderSize - ((slotsPerIteration - (slots \\ slotsPerIteration) bitAnd: slotsPerIteration - 1) * objectMemory bytesPerOop).
			 delta ~= 0 ifTrue:
				[cogit AddCq: delta R: destReg].
			 branch := cogit Jump: 0]
		ifFalse:
			[delta := objectMemory baseHeaderSize.
			 cogit AddCq: objectMemory baseHeaderSize R: destReg].
	loopCount := slots + slotsPerIteration - 1 // slotsPerIteration.
	self assert: loopCount > 1.
	loop := cogit Label.
	0 to: 7 do:
		[:i|
		inst := cogit MoveR: constReg Mw: i * objectMemory bytesPerOop r: destReg.
		slotsPerIteration - (slots \\ slotsPerIteration) = i ifTrue:
			[branch jmpTarget: inst]].
	"N.B. We get away with comparing against TempReg, which points to the start of the next
	 object, not necessarily immediately after the last slot, because if the size is a multiple of 8,
	 TempReg will point after the last slot, and if the size is not a multiple of 8 then the add of
	 slotsPerIteration * objectMemory bytesPerOop will put destReg beyond TempReg any way."
	cogit
		AddCq: slotsPerIteration * objectMemory bytesPerOop R: destReg;
		CmpR: TempReg R: destReg;
		JumpBelow: loop;
		SubCq: delta + (loopCount * slotsPerIteration * objectMemory bytesPerOop) R: destReg.
	^0