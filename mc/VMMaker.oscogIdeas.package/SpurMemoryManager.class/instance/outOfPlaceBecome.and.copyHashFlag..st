become implementation
outOfPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag
	<inline: #never> "in an effort to fix a compiler bug with two-way become post r3427"
	"Allocate two new objects, n1 & n2.  Copy the contents appropriately. Convert
	 obj1 and obj2 into forwarding objects pointing to n2 and n1 respectively"
	| clone1 clone2 |
	clone1 := (self isContextNonImm: obj1)
				ifTrue: [coInterpreter cloneContext: obj1]
				ifFalse: [self clone: obj1].
	clone2 := (self isContextNonImm: obj2)
				ifTrue: [coInterpreter cloneContext: obj2]
				ifFalse: [self clone: obj2].
	copyHashFlag
		ifTrue:
			[self setHashBitsOf: clone1 to: (self rawHashBitsOf: obj1).
			 self setHashBitsOf: clone2 to: (self rawHashBitsOf: obj2)]
		ifFalse:
			[self setHashBitsOf: clone1 to: (self rawHashBitsOf: obj2).
			 self setHashBitsOf: clone2 to: (self rawHashBitsOf: obj1)].
	self
		forward: obj1 to: clone2;
		forward: obj2 to: clone1.
	((self isYoungObject: obj1) ~= (self isYoungObject: clone2)
	 or: [(self isYoungObject: obj2) ~= (self isYoungObject: clone1)]) ifTrue:
		[becomeEffectsFlags := becomeEffectsFlags bitOr: OldBecameNewFlag]