object memory support
checkInterpreterIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Check that all oops in the interpreter's state
	 points to a header.  Answer if all checks pass."
	| ok |
	ok := true.
	(self checkOopIntegrity: specialObjectsOop named: 'specialObjectsOop')ifFalse:
		[ok := false].
	compilerInitialized
		ifTrue:
			[(self checkOopIntegrity: receiver named: 'receiver')ifFalse:
				[ok := false].
			(self checkOopIntegrity: method named: 'method')ifFalse:
				[ok := false]]
		ifFalse:
			[(self checkOopIntegrity: activeContext named: 'activeContext') ifFalse:
				[ok := false]].
	(self checkOopIntegrity: messageSelector named: 'messageSelector')ifFalse:
		[ok := false].
	(self checkOopIntegrity: newMethod named: 'newMethod')ifFalse:
		[ok := false].
	(self checkOopIntegrity: lkupClass named: 'lkupClass')ifFalse:
		[ok := false].
	(self checkOopIntegrity: receiverClass named: 'receiverClass')ifFalse:
		[ok := false].
	(self checkOopIntegrity: profileProcess named: 'profileProcess')ifFalse:
		[ok := false].
	(self checkOopIntegrity: profileMethod named: 'profileMethod')ifFalse:
		[ok := false].
	(self checkOopIntegrity: profileSemaphore named: 'profileSemaphore')ifFalse:
		[ok := false].

	"Callback support - check suspended callback list"
	1 to: jmpDepth do:
		[:i|
		(self checkOopIntegrity: (suspendedCallbacks at: i) named: 'suspendedCallbacks' index: i) ifFalse:
			[ok := false].
		(self checkOopIntegrity: (suspendedMethods at: i) named: 'suspendedMethods' index: i) ifFalse:
			[ok := false]].
	^ok