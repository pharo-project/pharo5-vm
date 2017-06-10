inline primitive support
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
	slots <= (slotsPerIteration := 8) ifTrue: "slotsPerIteration must be even; see cogit SubCq: objectMemory bytesPerOop R: TempReg below"
		[cogit genMoveConstant: objectMemory nilObject R: TempReg.
		 0 to: slots - 1 do:
			[:i| cogit MoveR: TempReg
					Mw: i * objectMemory wordSize + objectMemory baseHeaderSize
					r: destReg].
		^0].
	"self halt: 'genGetInstanceOfFixedClass:... ', slots asInteger."
	constReg := cogit allocateRegNotConflictingWith: destReg.
	cogit genMoveConstant: objectMemory nilObject R: constReg.
	
	slots \\ slotsPerIteration ~= 0
		ifTrue: "delta maps the offset at the loop entryPoint onto destReg + objectMemory baseHeaderSize"
			[delta := (slotsPerIteration - (slots \\ slotsPerIteration) * objectMemory bytesPerOop) - objectMemory baseHeaderSize.
			 delta > 0 ifTrue: [cogit SubCq: delta R: destReg].
			 delta < 0 ifTrue: [cogit AddCq: delta negated R: destReg].
			 "now delta maps (loopCount * slotsPerIteration * objectMemory bytesPerOop) + objectMemory baseHeaderSize - delta to the start of the object"
			 delta := delta + objectMemory baseHeaderSize.
			 (objectMemory bytesPerOop < objectMemory baseHeaderSize
			  and: [slots \\ 2 = 1]) ifTrue: "if end of loop is not at start of next object, adjust loop limit in TempReg to point to last field filled."
				[cogit SubCq: objectMemory bytesPerOop R: TempReg].
			 branch := cogit Jump: 0]
		ifFalse:
			[delta := 0.
			 cogit AddCq: objectMemory baseHeaderSize R: destReg].
	"loopCount is number of times through the increment of destReg."
	loopCount := slots + slotsPerIteration - 1 // slotsPerIteration.
	self assert: loopCount > 1.
	loop := cogit Label.
	0 to: 7 do:
		[:i|
		inst := cogit MoveR: constReg Mw: i * objectMemory bytesPerOop r: destReg.
		slotsPerIteration - (slots \\ slotsPerIteration) = i ifTrue:
			[branch jmpTarget: inst]].
	cogit
		AddCq: slotsPerIteration * objectMemory bytesPerOop R: destReg;
		CmpR: TempReg R: destReg;
		JumpBelow: loop;
		SubCq: (loopCount * slotsPerIteration * objectMemory bytesPerOop) + objectMemory baseHeaderSize - delta R: destReg.
	^0