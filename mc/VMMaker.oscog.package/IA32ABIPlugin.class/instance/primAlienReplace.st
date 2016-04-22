primitives-accessing
primAlienReplace
	"Copy some number of bytes from some source object starting at the index
	 into the receiver destination object from startIndex to stopIndex.  The  source
	 and destination may be Aliens or byte-indexable objects.  The primitive wll have
	 either of the following signatures:
	<Alien | indexableByteSubclass | indexableWordSubclass>
		primReplaceFrom: start <Integer>
		to: stop <Integer>
		with: replacement <Alien | indexableByteSubclass | indexableWordSubclass | Integer>
		startingAt: repStart <Integer> ^<self>
		<primitive: 'primitiveAlienReplace' error: errorCode module: 'IA32ABI'>
	<Anywhere>
		primReplaceIn: dest <Alien | indexableByteSubclass | indexableWordSubclass>
		from: start <Integer>
		to: stop <Integer>
		with: replacement <Alien | indexableByteSubclass | indexableWordSubclass | Integer>
		startingAt: repStart <Integer> ^<self>
		<primitive: 'primitiveAlienReplace' error: errorCode module: 'IA32ABI'>
	"
	| array start stop repl replStart dest src totalLength count |
	<export: true>
	array := interpreterProxy stackValue: 4.
	start := interpreterProxy stackIntegerValue: 3.
	stop := interpreterProxy stackIntegerValue: 2.
	repl := interpreterProxy stackValue: 1.
	replStart := interpreterProxy stackIntegerValue: 0.

	(interpreterProxy failed
	 or: [(interpreterProxy isWordsOrBytes: array) not]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].

	(self isAlien: array)
		ifTrue:
			[totalLength := self sizeField: array.
			 dest := (self startOfData: array withSize: totalLength) + start - 1.
			 totalLength = 0 "no bounds checks for zero-sized (pointer) Aliens"
				ifTrue: [totalLength := stop]
				ifFalse: [totalLength := totalLength abs]]
		ifFalse:
			[totalLength := interpreterProxy byteSizeOf: array.
			 dest := (self startOfByteData: array) + start - 1].
	(start >= 1 and: [start - 1 <= stop and: [stop <= totalLength]]) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].

	(interpreterProxy isKindOfInteger: repl)
		ifTrue:
			[src := (interpreterProxy positiveMachineIntegerValueOf: repl) + replStart - 1.
			 interpreterProxy failed ifTrue:
				[^interpreterProxy primitiveFailFor: PrimErrBadArgument]]
		ifFalse:
			[(self isAlien: repl)
				ifTrue:
					[totalLength := self sizeField: repl.
					 src := (self startOfData: repl withSize: totalLength) + replStart - 1.
					 totalLength = 0 "no bounds checks for zero-sized (pointer) Aliens"
						ifTrue: [totalLength := stop - start + replStart]
						ifFalse: [totalLength := totalLength abs]]
				ifFalse:
					[(interpreterProxy isWordsOrBytes: repl) ifFalse:
						[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
					 totalLength := interpreterProxy byteSizeOf: repl.
					 src := (self startOfByteData: repl) + replStart - 1].
			(replStart >= 1 and: [stop - start + replStart <= totalLength]) ifFalse:
				[^interpreterProxy primitiveFailFor: PrimErrBadIndex]].

	(interpreterProxy isOopImmutable: array) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].

	count := stop - start + 1.
	self mem: dest asVoidPointer mo: src asVoidPointer ve: count.

	interpreterProxy pop: interpreterProxy methodArgumentCount