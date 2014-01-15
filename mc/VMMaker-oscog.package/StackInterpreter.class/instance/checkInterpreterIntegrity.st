object memory support
checkInterpreterIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Check that all oops in the interpreter's state
	 points to a header.  Answer if all checks pass."
	| ok |
	ok := true.
	(objectMemory checkOopIntegrity: objectMemory specialObjectsOop named: 'specialObjectsOop')ifFalse:
		[ok := false].
	(objectMemory isIntegerObject: messageSelector) ifFalse:
		[(objectMemory checkOopIntegrity: messageSelector named: 'messageSelector')ifFalse:
			[ok := false]].
	(objectMemory checkOopIntegrity: newMethod named: 'newMethod')ifFalse:
		[ok := false].
	(objectMemory checkOopIntegrity: lkupClass named: 'lkupClass')ifFalse:
		[ok := false].
	(objectMemory checkOopIntegrity: profileProcess named: 'profileProcess')ifFalse:
		[ok := false].
	(objectMemory checkOopIntegrity: profileMethod named: 'profileMethod')ifFalse:
		[ok := false].
	(objectMemory checkOopIntegrity: profileSemaphore named: 'profileSemaphore')ifFalse:
		[ok := false].
	tempOop = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop named: 'tempOop')ifFalse:
			[ok := false]].

	"Callback support - check suspended callback list"
	1 to: jmpDepth do:
		[:i|
		(objectMemory checkOopIntegrity: (suspendedCallbacks at: i) named: 'suspendedCallbacks' index: i) ifFalse:
			[ok := false].
		(objectMemory checkOopIntegrity: (suspendedMethods at: i) named: 'suspendedMethods' index: i) ifFalse:
			[ok := false]].

	self checkLogIntegrity ifFalse:
		[ok := false].

	^ok