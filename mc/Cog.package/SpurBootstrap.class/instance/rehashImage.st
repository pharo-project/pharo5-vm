bootstrap image
rehashImage
	"Rehash all collections in newHeap.
	 Find out which classes implement rehash, entering a 1 against their classIndex in rehashFlags.
	 Enumerate all objects, rehashing those whose class has a bit set in rehashFlags."
	| n sim rehashFlags dotDate rehashSym sizeSym |
	rehashSym := map at: (self findSymbol: #rehash).
	sizeSym := map at: (self findSymbol: #size).
	sim := StackInterpreterSimulator 
				onObjectMemory: newHeap 
				options: #(ObjectMemory #Spur32BitMemoryManager).
	sim 
		setImageHeaderFlagsFrom: oldInterpreter getImageHeaderFlags;
		imageName: 'spur image';
		assertValidExecutionPointersAtEachStep: false..
	newHeap coInterpreter: sim.
	sim bootstrapping: true.
	sim initializeInterpreter: 0.
	sim instVarNamed: 'methodDictLinearSearchLimit' put: SmallInteger maxVal.
	(imageTypes includes: 'cuis') ifTrue:
		[newHeap scavenger growRememberedSet]. "Rehashing a 4.2 Cuis image overflows the 768 element high tide."
	
	sim redirectTranscriptToHost.

	newHeap
		setHashBitsOf: newHeap nilObject to: 1;
		setHashBitsOf: newHeap falseObject to: 2;
		setHashBitsOf: newHeap trueObject to: 3.

	rehashFlags := ByteArray new: newHeap numClassTablePages * newHeap classTablePageSize.
	n := 0.
	newHeap classTableObjectsDo:
		[:class| | classIndex |
		sim messageSelector: rehashSym.
		"Lookup rehash but don't be fooled by ProtoObject>>rehash, which is just ^self."
		((sim lookupOrdinaryNoMNUEtcInClass: class) = 0
		 and: [(sim isQuickPrimitiveIndex: (sim primitiveIndexOf: (sim instVarNamed: 'newMethod'))) not]) ifTrue:
			[n := n + 1.
			 classIndex := newHeap rawHashBitsOf: class.
			 rehashFlags
				at: classIndex >> 3 + 1
				put: ((rehashFlags at: classIndex >> 3 + 1)
						bitOr: (1 << (classIndex bitAnd: 7)))]].
	Transcript cr; print: n; nextPutAll: ' classes understand rehash. rehashing instances...'; flush.
	dotDate := Time now asSeconds.
	n := 0.
	self withExecutableInterpreter: sim
		do: [sim setBreakSelector: 'error:'.
			 "don't rehash twice (actually without limit), so don't rehash any new objects created."
			 newHeap allExistingOldSpaceObjectsDo:
				[:o| | classIndex |
				classIndex := newHeap classIndexOf: o.
				((rehashFlags at: classIndex >> 3 + 1) anyMask: 1 << (classIndex bitAnd: 7)) ifTrue:
					[Time now asSeconds > dotDate ifTrue:
					 	[Transcript nextPut: $.; flush.
						 dotDate := Time now asSeconds].
					 "2845 = n ifTrue: [self halt]."
					 "Rehash an object if its size is > 0.
					  Symbol implements rehash, but let's not waste time rehashing it; in Squeak
					  up to 2013 symbols are kept in a set which will get reashed anyway..
					  Don't rehash empty collections; they may be large for a reason and rehashing will shrink them."
					 ((sim addressCouldBeClassObj: o)
					   or: [(self interpreter: sim
							object: o
							perform: sizeSym
							withArguments: #()) = (newHeap integerObjectOf: 0)]) ifFalse:
						[self interpreter: sim
							object: o
							perform: rehashSym
							withArguments: #()]]]]