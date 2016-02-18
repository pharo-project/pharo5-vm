miscellaneous bytecodes
unaryInlinePrimitive: primIndex
	"SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	<option: #SistaVM>
	| result |
	primIndex caseOf: {
		"1000	unchecked class"
		[0]	->	[result := objectMemory fetchClassOf: self internalStackTop.
				 self internalStackTopPut: result].
		"1001	unchecked pointer numSlots"
		[1]	->	[result := objectMemory numSlotsOf: self internalStackTop.
				 self internalStackTopPut: (objectMemory integerObjectOf: result)].
		"1002	unchecked pointer basicSize"
		[2]	->	[result := (objectMemory numSlotsOf: self internalStackTop)
						- (objectMemory fixedFieldsOfClass: (objectMemory fetchClassOfNonImm: self internalStackTop)).
				 self internalStackTopPut: (objectMemory integerObjectOf: result)].
		"1003	unchecked byte8Type format numBytes (includes CompiledMethod)"
		[3]	->	[result := objectMemory numBytesOf: self internalStackTop.
				 self internalStackTopPut: (objectMemory integerObjectOf: result)].
		"1004	unchecked short16Type format numShorts"
		[4]	->	[result := objectMemory num16BitUnitsOf: self internalStackTop.
				 self internalStackTopPut: (objectMemory integerObjectOf: result)].
		"1005	unchecked word32Type format numWords"
		[5]	->	[result := objectMemory num32BitUnitsOf: self internalStackTop.
				 self internalStackTopPut: (objectMemory integerObjectOf: result)].
		"1006	unchecked doubleWord64Type format numDoubleWords"
		[6]	->	[result := objectMemory num64BitUnitsOf: self internalStackTop.
				 self internalStackTopPut: (objectMemory integerObjectOf: result)] }
	otherwise:
		[localIP := localIP - 3.
		 self respondToUnknownBytecode]