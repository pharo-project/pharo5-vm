object memory support
checkInterpreterIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Check that all oops in the interpreter's state
	 points to a header.  Answer 0 if all checks pass."
	| flags |
	flags := 0.
	(self checkOopIntegrity: specialObjectsOop named: 'specialObjectsOop')ifFalse:
		[flags := 1].
	compilerInitialized
		ifTrue:
			[(self checkOopIntegrity: receiver named: 'receiver')ifFalse:
				[flags := 2].
			(self checkOopIntegrity: method named: 'method')ifFalse:
				[flags := 4]]
		ifFalse:
			[(self checkOopIntegrity: activeContext named: 'activeContext') ifFalse:
				[flags := 8]].
	(self checkOopIntegrity: messageSelector named: 'messageSelector')ifFalse:
		[flags := 16].
	(self checkOopIntegrity: newMethod named: 'newMethod')ifFalse:
		[flags := 32].
	(self checkOopIntegrity: lkupClass named: 'lkupClass')ifFalse:
		[flags := 64].
	(self checkOopIntegrity: receiverClass named: 'receiverClass')ifFalse:
		[flags := 128].
	(self checkOopIntegrity: profileProcess named: 'profileProcess')ifFalse:
		[flags := 256].
	(self checkOopIntegrity: profileMethod named: 'profileMethod')ifFalse:
		[flags := 512].
	(self checkOopIntegrity: profileSemaphore named: 'profileSemaphore')ifFalse:
		[flags := 1024].

	"Callback support - check suspended callback list"
	1 to: jmpDepth do:
		[:i|
		(self checkOopIntegrity: (suspendedCallbacks at: i) named: 'suspendedCallbacks' index: i) ifFalse:
			[flags := 2048].
		(self checkOopIntegrity: (suspendedMethods at: i) named: 'suspendedMethods' index: i) ifFalse:
			[flags := 4096]].
	^flags