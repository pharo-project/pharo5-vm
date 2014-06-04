become implementation
scanClassPostBecome: startClassObj effects: becomeEffects
	"Scan a class in the class table post-become.  Make sure the superclass
	 chain contains no forwarding pointers, and that the method dictionaries
	 are not forwarded either.  N.B. we don't follow methods or their
	 methodClassAssociations since we can't guarantee that forwarders
	 to compiled methods are not stored in method dictionaries via at:put:
	 and so have to cope with forwarding pointers to compiled methods
	 in method dictionaries anyway.  Instead the [Co]Interpreter must
	 follow forwarders when fetching from method dictionaries and follow
	 forwarders on become in the method cache and method zone."

	| classObj obj |
	"Algorithm depends on this to terminate loop at root of superclass chain."
	self assert: (self rawHashBitsOf: nilObj) ~= 0.
	self assert: (becomeEffects anyMask: BecamePointerObjectFlag). "otherwise why bother?"
	classObj := startClassObj.

	["e.g. the Newspeak bootstrap creates fake classes that contain bogus superclasses.
	  Hence be cautious."
	 ((self isPointers: classObj)
	   and: [(self numSlotsOf: classObj) > MethodDictionaryIndex]) ifFalse:
		[^self].
	 obj := self followObjField: MethodDictionaryIndex ofObject: classObj.
	 "Solving the becommed method stored into a method dictionary object issue is
	  easy; just have a read barrier on fetching the method.  But solving the read barrier
	  for selectors is more difficult (because selectors are currently not read, just their
	  oops).  For now punt on the issue and simply follow all selectors on become"
	 self flag: 'need to fix the selector and methodDictionary issue'.
	 true
		ifTrue: [self followForwardedObjectFields: obj toDepth: 0]
		ifFalse: [self followObjField: MethodArrayIndex ofObject: obj].
	 obj := self followObjField: SuperclassIndex ofObject: classObj.
	 "If the superclass has an identityHash then either it is nil, or is in the class table.
	  Tail recurse."
	 (self rawHashBitsOf: obj) = 0] whileTrue:
		["effectively self scanClassPostBecome: obj"
		 classObj := obj]