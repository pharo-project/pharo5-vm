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
	"No longer check messageSelector; it is ephemeral, not living beyond message lookup.
	(objectMemory isNonImmediate: messageSelector) ifTrue:
		[(objectMemory checkOopIntegrity: messageSelector named: 'messageSelector')ifFalse:
			[ok := false]]."
	(objectMemory checkOopIntegrity: newMethod named: 'newMethod')ifFalse:
		[ok := false].
	"No longer check lkupClass; it is ephemeral, not living beyond message lookup.
	(objectMemory checkOopIntegrity: lkupClass named: 'lkupClass')ifFalse:
		[ok := false]."
	(objectMemory checkOopIntegrity: profileProcess named: 'profileProcess')ifFalse:
		[ok := false].
	(objectMemory checkOopIntegrity: profileMethod named: 'profileMethod')ifFalse:
		[ok := false].
	(objectMemory checkOopIntegrity: profileSemaphore named: 'profileSemaphore')ifFalse:
		[ok := false].
	tempOop = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop named: 'tempOop')ifFalse:
			[ok := false]].
	tempOop2 = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop2 named: 'tempOop2')ifFalse:
			[ok := false]].
	tempOop3 = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop3 named: 'tempOop3')ifFalse:
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