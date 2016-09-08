become implementation
becomeEffectFlagsFor: objOop
	"Answer the appropriate become effect flags for objOop, or 0 if none.
	 The effect flags determine how much work is done after the become
	 in following forwarding pointers, voiding method caches, etc."
	<inline: false>
	^(self isPointersNonImm: objOop)
		ifTrue:
			[| hash |
			 ((hash := self rawHashBitsOf: objOop) ~= 0
			  and: [(self classAtIndex: hash) = objOop])
				ifTrue: [BecamePointerObjectFlag + BecameActiveClassFlag]
				ifFalse: [BecamePointerObjectFlag]]
		ifFalse:
			[(self isCompiledMethod: objOop)
				ifTrue: [BecameCompiledMethodFlag]
				ifFalse: [0]]