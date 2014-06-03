become implementation
becomeEffectFlagsFor: objOop
	"Answer the appropriate become effect flags for objOop, or 0 if none.
	 The effect flags affect how much work is done after the become in
	 following forwarding pointers."
	<inline: false>
	^(self isPointersNonImm: objOop)
		ifTrue:
			[BecamePointerObjectFlag
			"older code that identified class objects, but it isn't helpful:"
			"| hash |
			 (hash := self rawHashBitsOf: objOop) = 0
				ifTrue: ""Can't identify an abstract class by the class table; it may not be there-in.""
					[(coInterpreter objCouldBeClassObj: objOop)
						ifTrue: [BecamePointerObjectFlag + BecameClassFlag]
						ifFalse: [BecamePointerObjectFlag]]
				ifFalse: ""if an object has a hash and it's a class it must be in the table.""
					[(self classAtIndex: hash) = objOop
						ifTrue: [BecamePointerObjectFlag + BecameClassFlag]
						ifFalse: [BecamePointerObjectFlag]]"]
		ifFalse:
			[(self isCompiledMethod: objOop)
				ifTrue: [BecameCompiledMethodFlag]
				ifFalse: [0]]