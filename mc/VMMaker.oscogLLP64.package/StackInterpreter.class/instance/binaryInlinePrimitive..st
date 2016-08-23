miscellaneous bytecodes
binaryInlinePrimitive: primIndex
	"SistaV1:	248		11111000 	iiiiiiii		mjjjjjjj		Call Primitive #iiiiiiii + (jjjjjjj * 256) m=1 means inlined primitive, no hard return after execution."
	<option: #SistaVM>
	| result result64 |
	primIndex caseOf: {
		"2000	unchecked SmallInteger #+.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[0]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															+ (objectMemory integerValueOf: self internalStackTop)).
				 self internalPop: 1; internalStackTopPut: result].
		"2001	unchecked SmallInteger #-.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[1]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															- (objectMemory integerValueOf: self internalStackTop)).
				 self internalPop: 1; internalStackTopPut: result].
		"2002	unchecked SmallInteger #*.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[2]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															* (objectMemory integerValueOf: self internalStackTop)).
				 self internalPop: 1; internalStackTopPut: result].
		"2003	unchecked SmallInteger #/.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[3]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															/ (objectMemory integerValueOf: self internalStackTop)).
				 self internalPop: 1; internalStackTopPut: result].
		"2004	unchecked SmallInteger #//.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[4]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															// (objectMemory integerValueOf: self internalStackTop)).
				 self internalPop: 1; internalStackTopPut: result].
		"2005	unchecked SmallInteger #\\.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[5]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															\\ (objectMemory integerValueOf: self internalStackTop)).
				 self internalPop: 1; internalStackTopPut: result].
		"2006	unchecked SmallInteger #quo:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[6]	->	[| rcvr arg |
				 rcvr := objectMemory integerValueOf: (self internalStackValue: 1).
				 arg := objectMemory integerValueOf: self internalStackTop.
				 result := self quot: rcvr ient: arg.
				 self internalPop: 1; internalStackTopPut: (objectMemory integerObjectOf: result)].

		"2016	unchecked SmallInteger #bitAnd:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[16]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															bitAnd: (objectMemory integerValueOf: self internalStackTop)).
					 self internalPop: 1; internalStackTopPut: result].
		"2017	unchecked SmallInteger #bitOr:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[17]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															bitOr: (objectMemory integerValueOf: self internalStackTop)).
					 self internalPop: 1; internalStackTopPut: result].
		"2018	unchecked SmallInteger #bitXor:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[18]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															bitXor: (objectMemory integerValueOf: self internalStackTop)).
					 self internalPop: 1; internalStackTopPut: result].
		"2019	unchecked SmallInteger #bitShift:.  Both arguments are SmallIntegers and the result fits in a SmallInteger (* depends on word size)"
		[19]	->	[result := objectMemory integerObjectOf: ((objectMemory integerValueOf: (self internalStackValue: 1))
															bitShift: (objectMemory integerValueOf: self internalStackTop)).
					 self internalPop: 1; internalStackTopPut: result].

		"2032	unchecked SmallInteger #>.  Both arguments are SmallIntegers"
		[32]	->	[result := objectMemory booleanObjectOf: ((self internalStackValue: 1) > self internalStackTop).
					 self internalPop: 1; internalStackTopPut: result].
		"2033	unchecked SmallInteger #<.  Both arguments are SmallIntegers"
		[33]	->	[result := objectMemory booleanObjectOf: ((self internalStackValue: 1) < self internalStackTop).
					 self internalPop: 1; internalStackTopPut: result].
		"2034	unchecked SmallInteger #>=.  Both arguments are SmallIntegers"
		[34]	->	[result := objectMemory booleanObjectOf: ((self internalStackValue: 1) >= self internalStackTop).
					 self internalPop: 1; internalStackTopPut: result].
		"2035	unchecked SmallInteger #<=.  Both arguments are SmallIntegers"
		[35]	->	[result := objectMemory booleanObjectOf: ((self internalStackValue: 1) <= self internalStackTop).
					 self internalPop: 1; internalStackTopPut: result].
		"2036	unchecked SmallInteger #=.  Both arguments are SmallIntegers"
		[36]	->	[result := objectMemory booleanObjectOf: ((self internalStackValue: 1) = self internalStackTop).
					 self internalPop: 1; internalStackTopPut: result].
		"2037	unchecked SmallInteger #~=.  Both arguments are SmallIntegers"
		[37]	->	[result := objectMemory booleanObjectOf: ((self internalStackValue: 1) ~= self internalStackTop).
					 self internalPop: 1; internalStackTopPut: result].

		"2064	unchecked Pointer Object>>at:.		The receiver is guaranteed to be a pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger"
		[64]	->	[result := objectMemory
									fetchPointer: (objectMemory integerValueOf: self internalStackTop) - 1
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: result].
		"2065	unchecked Byte Object>>at:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger."
		[65]	->	[result := objectMemory
									fetchByte: (objectMemory integerValueOf: self internalStackTop) - 1
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (objectMemory integerObjectOf: result)].
		"2066	unchecked 16-bit Word Object>>at:.			The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger."
		[66]	->	[result := objectMemory
									fetchShort16: (objectMemory integerValueOf: self internalStackTop) - 1
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (objectMemory integerObjectOf: result)].
		"2067	unchecked 32 bit Word Object>>at:.	The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger or a LargePositiveInteger."
		[67]	->	[result := objectMemory
									fetchLong32: (objectMemory integerValueOf: self internalStackTop) - 1
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (self signed64BitValueOf: result)].
		"2068	unchecked 64 bit Word Object>>at:.		The receiver is guaranteed to be a non-pointer object.  The 0-relative (1-relative?) index is an in-range SmallInteger.  The result is a SmallInteger or a LargePositiveInteger."
		[68]	->	[result64 := objectMemory
									fetchLong64: (objectMemory integerValueOf: self internalStackTop) - 1
									ofObject: (self internalStackValue: 1).
					 self internalPop: 1; internalStackTopPut: (self signed64BitValueOf: result)] }
	otherwise:
		[localIP := localIP - 3.
		 self respondToUnknownBytecode]