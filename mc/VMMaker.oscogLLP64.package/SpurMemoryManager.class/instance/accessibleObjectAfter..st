object enumeration
accessibleObjectAfter: objOop
	"Answer the accessible object following the given object or 
	free chunk in the heap. Return nil when heap is exhausted.
	 This is for primitiveNextObject subsequent to primtiiveSomeObject.
	 It also tries to handle more general use by ordering objects as
		eden
		past
		old
	 but this is tricky becaus ethe order in memory is
		past
		eden
		old"
	<inline: false>
	| objAfter |
	objAfter := objOop.
	(self oop: objAfter isLessThan: nilObj) ifTrue: "object in new space"
		[self assert: ((self isInEden: objOop) or: [self isInPastSpace: objOop]).
		 (self oop: objAfter isGreaterThan: pastSpaceStart) ifTrue:
			["Obj is in eden.  Answer next normal object in eden, if there is one."
			 [objAfter := self objectAfter: objAfter limit: freeStart.
			  self oop: objAfter isLessThan: freeStart] whileTrue:
				[(self isNormalObject: objAfter) ifTrue:
					[^objAfter]].
			 "There wasn't a next object in eden. If past space is empty answer nilObj."
			 pastSpaceStart <= scavenger pastSpace start ifTrue:
				[^nilObj].
			 "If the first object in pastSpace is OK, answer it, otherwise fall through to enumerate past space."
			 objAfter := self objectStartingAt: scavenger pastSpace start.
			 (self isNormalObject: objAfter) ifTrue:
				[^objAfter]].
		 "Either objOop was in pastSpace, or enumeration exhaused eden, so enumerate past space."
		 [objAfter := self objectAfter: objAfter limit: pastSpaceStart.
		  self oop: objAfter isLessThan: pastSpaceStart] whileTrue:
			[(self isNormalObject: objAfter) ifTrue:
				[^objAfter]].
		 ^nilObj].
	[objAfter := self objectAfter: objAfter limit: endOfMemory.
	 objAfter = endOfMemory ifTrue:
		[^nil].
	 (self isNormalObject: objAfter) ifTrue:
		[^objAfter]] repeat