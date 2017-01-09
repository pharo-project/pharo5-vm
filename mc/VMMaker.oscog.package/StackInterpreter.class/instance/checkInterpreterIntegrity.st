object memory support
checkInterpreterIntegrity
	"Perform an integrity/leak check using the heapMap.  Assume
	 clearLeakMapAndMapAccessibleObjects has set a bit at each
	 object's header.  Check that all oops in the interpreter's state
	 points to a header.  Answer 0 if all checks pass."
	| flags |
	flags := 0.
	(objectMemory checkOopIntegrity: objectMemory specialObjectsOop named: 'specialObjectsOop')ifFalse:
		[flags := 1].
	"No longer check messageSelector; it is ephemeral, not living beyond message lookup.
	(objectMemory isNonImmediate: messageSelector) ifTrue:
		[(objectMemory checkOopIntegrity: messageSelector named: 'messageSelector')ifFalse:
			[ok := false]]."
	(objectMemory checkOopIntegrity: newMethod named: 'newMethod')ifFalse:
		[flags := flags + 2].
	"No longer check lkupClass; it is ephemeral, not living beyond message lookup.
	(objectMemory checkOopIntegrity: lkupClass named: 'lkupClass')ifFalse:
		[ok := false]."
	(objectMemory checkOopIntegrity: profileProcess named: 'profileProcess')ifFalse:
		[flags := flags + 4].
	(objectMemory checkOopIntegrity: profileMethod named: 'profileMethod')ifFalse:
		[flags := flags + 8].
	(objectMemory checkOopIntegrity: profileSemaphore named: 'profileSemaphore')ifFalse:
		[flags := flags + 16].
	tempOop = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop named: 'tempOop')ifFalse:
			[flags := flags + 32]].
	tempOop2 = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop2 named: 'tempOop2')ifFalse:
			[flags := flags + 64]].
	tempOop3 = 0 ifFalse:
		[(objectMemory checkOopIntegrity: tempOop3 named: 'tempOop3')ifFalse:
			[flags := flags + 128]].

	"Callback support - check suspended callback list"
	1 to: jmpDepth do:
		[:i|
		(objectMemory checkOopIntegrity: (suspendedCallbacks at: i) named: 'suspendedCallbacks' index: i) ifFalse:
			[flags := flags + 256].
		(objectMemory checkOopIntegrity: (suspendedMethods at: i) named: 'suspendedMethods' index: i) ifFalse:
			[flags := flags + 512]].

	self checkLogIntegrity ifFalse:
		[flags := flags + 1024].

	^flags