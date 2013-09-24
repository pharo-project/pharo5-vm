object enumeration
objectBefore: objOop
	| prev |
	prev := nil.
	objOop < newSpaceLimit ifTrue:
		[self allNewSpaceObjectsDo:
			[:o|
			 o >= objOop ifTrue:
				[^prev].
			 prev := o].
		 ^prev].
	self allOldSpaceObjectsDo:
		[:o|
		 o >= objOop ifTrue:
			[^prev].
		 prev := o].
	^prev