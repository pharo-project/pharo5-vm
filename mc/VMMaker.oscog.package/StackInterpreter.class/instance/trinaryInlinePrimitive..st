miscellaneous bytecodes
trinaryInlinePrimitive: primIndex
	"SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	<option: #SistaVM>
	| result |
	primIndex caseOf: {

		"3000	unchecked Pointer Object>>at:put:.			The receiver is guaranteed to be a pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger"
		[0]	->	[result := self internalStackTop.
				 objectMemory
					storePointer: (objectMemory integerValueOf: (self internalStackValue: 1)) - 1
					ofObject: (self internalStackValue: 2)
					withValue: result.
				 self internalPop: 2; internalStackTopPut: result].
		"3001	unchecked Byte Object>>at:put:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 8 bits."
		[1]	->	[result := self internalStackTop.
				 objectMemory
					storeByte: (objectMemory integerValueOf: (self internalStackValue: 1)) - 1
					ofObject: (self internalStackValue: 2)
					withValue: (objectMemory integerValueOf: result).
				 self internalPop: 2; internalStackTopPut: result].
		"3002	unchecked Word Object>>at:put:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 16 bits."
		[2]	->	[result := self internalStackTop.
				 objectMemory
					storeShort16: (objectMemory integerValueOf: (self internalStackValue: 1)) - 1
					ofObject: (self internalStackValue: 2)
					withValue: (objectMemory integerValueOf: result).
				 self internalPop: 2; internalStackTopPut: result].
		"3003	unchecked DoubleWord Object>>at:put:.	The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 32 bits."
		[3]	->	[result := self internalStackTop.
				 objectMemory
					storeLong32: (objectMemory integerValueOf: (self internalStackValue: 1)) - 1
					ofObject: (self internalStackValue: 2)
					withValue: (objectMemory integerValueOf: result).
				 self internalPop: 2; internalStackTopPut: result].
		"3004	unchecked QuadWord Object>>at:put:.		The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 64 bits."
		[4]	->	[result := self internalStackTop.
				 objectMemory
					storeLong64: (objectMemory integerValueOf: (self internalStackValue: 1)) - 1
					ofObject: (self internalStackValue: 2)
					withValue: (objectMemory integerValueOf: result).
				 self internalPop: 2; internalStackTopPut: result] }
	otherwise:
		[localIP := localIP - 3.
		 self respondToUnknownBytecode]