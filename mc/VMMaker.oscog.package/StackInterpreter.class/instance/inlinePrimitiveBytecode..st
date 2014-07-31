miscellaneous bytecodes
inlinePrimitiveBytecode: primIndex
	"SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	<option: #SistaVM>
	| result result64 |
	primIndex caseOf: {
		"0	unchecked SmallInteger #+.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[0]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															+ (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].
		"1	unchecked SmallInteger #-.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[1]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															- (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].
		"2	unchecked SmallInteger #*.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[2]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															* (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].
		"3	unchecked SmallInteger #/.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[3]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															/ (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].
		"4	unchecked SmallInteger #//.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[4]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															// (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].
		"5	unchecked SmallInteger #\\.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[5]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															\\ (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].
		"6	unchecked SmallInteger #quo:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[6]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															quo: (objectMemory integerValueOf: (self internalStackValue: 1))).
				 self internalPop: 1; internalStackTopPut: result].

		"16	unchecked SmallInteger #bitAnd:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[16]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															bitAnd: (objectMemory integerValueOf: (self internalStackValue: 1))).
					 self internalPop: 1; internalStackTopPut: result].
		"17	unchecked SmallInteger #bitOr:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[17]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															bitOr: (objectMemory integerValueOf: (self internalStackValue: 1))).
					 self internalPop: 1; internalStackTopPut: result].
		"18	unchecked SmallInteger #bitXor:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[18]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															bitXor: (objectMemory integerValueOf: (self internalStackValue: 1))).
					 self internalPop: 1; internalStackTopPut: result].
		"19	unchecked SmallInteger #bitShift:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[19]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: self internalStackTop)
															bitShift: (objectMemory integerValueOf: (self internalStackValue: 1))).
					 self internalPop: 1; internalStackTopPut: result].

		"32	unchecked SmallInteger #>.  Both arguments are SmallIntegers"
		[32]	->	[result := objectMemory booleanObjectOf: (self internalStackTop > (self internalStackValue: 1)).
					 self internalPop: 1; internalStackTopPut: result].
		"33	unchecked SmallInteger #<.  Both arguments are SmallIntegers"
		[33]	->	[result := objectMemory booleanObjectOf: (self internalStackTop < (self internalStackValue: 1)).
					 self internalPop: 1; internalStackTopPut: result].
		"34	unchecked SmallInteger #>=.  Both arguments are SmallIntegers"
		[34]	->	[result := objectMemory booleanObjectOf: (self internalStackTop >= (self internalStackValue: 1)).
					 self internalPop: 1; internalStackTopPut: result].
		"35	unchecked SmallInteger #<=.  Both arguments are SmallIntegers"
		[35]	->	[result := objectMemory booleanObjectOf: (self internalStackTop <= (self internalStackValue: 1)).
					 self internalPop: 1; internalStackTopPut: result].
		"36	unchecked SmallInteger #=.  Both arguments are SmallIntegers"
		[36]	->	[result := objectMemory booleanObjectOf: (self internalStackTop = (self internalStackValue: 1)).
					 self internalPop: 1; internalStackTopPut: result].
		"37	unchecked SmallInteger #~=.  Both arguments are SmallIntegers"
		[37]	->	[result := objectMemory booleanObjectOf: (self internalStackTop ~= (self internalStackValue: 1)).
					 self internalPop: 1; internalStackTopPut: result].

		"64	unchecked Pointer Object>>at:.		The receiver is guaranteed to be a pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger"
		[64]	->	[result := objectMemory
									fetchPointer: (objectMemory integerValueOf: self internalStackTop)
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: result].
		"65	unchecked Byte Object>>at:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger."
		[65]	->	[result := objectMemory
									fetchByte: (objectMemory integerValueOf: self internalStackTop)
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (objectMemory integerObjectOf: result)].
		"66	unchecked Word Object>>at:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger."
		[66]	->	[result := objectMemory
									fetchShort: (objectMemory integerValueOf: self internalStackTop)
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (objectMemory integerObjectOf: result)].
		"67	unchecked DoubleWord Object>>at:.	The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger or a LargePositiveInteger."
		[67]	->	[result := objectMemory
									fetchLong32: (objectMemory integerValueOf: self internalStackTop)
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (self signed64BitValueOf: result)].
		"68	unchecked QuadWord Object>>at:.		The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger or a LargePositiveInteger."
		[68]	->	[result64 := objectMemory
									fetchLong64: (objectMemory integerValueOf: self internalStackTop)
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (self signed64BitValueOf: result)].

		"80	unchecked Pointer Object>>at:put:.			The receiver is guaranteed to be a pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger"
		[80]	->	[result := self internalStackTop.
					 objectMemory
						storePointer: (objectMemory integerValueOf: (self internalStackValue: 1))
						ofObject: (self internalStackValue: 1)
						withValue: result.
					 self internalPop: 2; internalStackTopPut: result].
		"81	unchecked Byte Object>>at:put:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 8 bits."
		[81]	->	[result := self internalStackTop.
					 objectMemory
						storeByte: (objectMemory integerValueOf: (self internalStackValue: 1))
						ofObject: (self internalStackValue: 1)
						withValue: (objectMemory integerValueOf: result).
					 self internalPop: 2; internalStackTopPut: result].
		"82	unchecked Word Object>>at:put:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 16 bits."
		[82]	->	[result := self internalStackTop.
					 objectMemory
						storeShort: (objectMemory integerValueOf: (self internalStackValue: 1))
						ofObject: (self internalStackValue: 1)
						withValue: (objectMemory integerValueOf: result).
					 self internalPop: 2; internalStackTopPut: result].
		"83	unchecked DoubleWord Object>>at:put:.	The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 32 bits."
		[83]	->	[result := self internalStackTop.
					 objectMemory
						storeLong32: (objectMemory integerValueOf: (self internalStackValue: 1))
						ofObject: (self internalStackValue: 1)
						withValue: (objectMemory integerValueOf: result).
					 self internalPop: 2; internalStackTopPut: result].
		"84	unchecked QuadWord Object>>at:put:.		The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The argument is a SmallInteger.  The primitive stores the least significant 64 bits."
		[84]	->	[result := self internalStackTop.
					 objectMemory
						storeLong64: (objectMemory integerValueOf: (self internalStackValue: 1))
						ofObject: (self internalStackValue: 1)
						withValue: (objectMemory integerValueOf: result).
					 self internalPop: 2; internalStackTopPut: result] }
	otherwise:
		[localIP := localIP - 3.
		 self respondToUnknownBytecode]