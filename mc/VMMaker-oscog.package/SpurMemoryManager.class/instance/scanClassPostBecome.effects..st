become implementation
scanClassPostBecome: startClassObj effects: becomeEffects
	"Scan a class in the class table post-become.  Make sure the superclass
	 chain contains no forwarding pointers, and that the method dictionaries
	 are not forwarded either, and that methoidClassAssociations in methods
	 are not followed either."

	| classObj obj obj2 |
	"Algorithm depend on this to terminate loop at root of superclass chain."
	self assert: (self rawHashBitsOf: nilObj) ~= 0.
	self assert: (becomeEffects anyMask: BecamePointerObjectFlag+BecameCompiledMethodFlag). "otherwise why bother?"
	classObj := startClassObj.

	[obj := self fetchPointer: MethodDictionaryIndex ofObject: classObj.
	 self assert: (self isNonImmediate: obj).
	 (self isForwarded: obj) ifTrue:
		[obj := self followForwarded: obj.
		 self storePointer: MethodDictionaryIndex ofObject: classObj withValue: obj].
	 obj2 := self fetchPointer: MethodArrayIndex ofObject: obj.
	 self assert: (self isNonImmediate: obj2).
	 (self isForwarded: obj2) ifTrue:
		[obj2 := self followForwarded: obj2.
		 self storePointer: MethodArrayIndex ofObject: obj withValue: obj2].
	 "Only need to follow pointers in MethodArray if we've became any compiled methods..."
	 (becomeEffects anyMask: BecameCompiledMethodFlag) ifTrue:
		[self followForwardedObjectFields: obj2 toDepth: 0].
	 "But the methodClassAssociations there-in need to be followed if we've done any pointer becomes."
	 (becomeEffects anyMask: BecamePointerObjectFlag) ifTrue:
		[0 to: (self numSlotsOf: obj2) - 1 do:
			[:i|
			obj := self fetchPointer: i ofObject: obj2.
			(self isOopCompiledMethod: obj2) ifTrue:
				[coInterpreter followNecessaryForwardingInMethod: obj2]]].

	 obj := self fetchPointer: SuperclassIndex ofObject: classObj.
	 self assert: (self isNonImmediate: obj).
	 (self isForwarded: obj) ifTrue:
		[obj := self followForwarded: obj.
		 self storePointer: SuperclassIndex ofObject: classObj withValue: obj].

	"If the superclass has an identityHash then either it is nil, or is in the class table.
	 Tail recurse."
	(self rawHashBitsOf: obj) = 0] whileTrue:
		["effectively self scanClassPostBecome: obj"
		 classObj := obj]