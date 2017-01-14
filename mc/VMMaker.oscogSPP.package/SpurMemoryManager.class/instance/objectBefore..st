object enumeration
objectBefore: objOop
	<api>
	| prev |
	prev := nil.
	(self oop: objOop isLessThan: newSpaceLimit) ifTrue:
		[self allNewSpaceEntitiesDo:
			[:o|
			 (self oop: o isGreaterThanOrEqualTo: objOop) ifTrue:
				[^prev].
			 prev := o].
		 ^prev].
	self allOldSpaceEntitiesDo:
		[:o|
		 (self oop: o isGreaterThanOrEqualTo: objOop) ifTrue:
			[^prev].
		 prev := o].
	^prev