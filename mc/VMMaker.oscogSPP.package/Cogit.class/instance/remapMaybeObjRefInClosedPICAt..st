garbage collection
remapMaybeObjRefInClosedPICAt: mcpc
	"Remap a potential object reference from a closed PIC.
	 This may be an object reference, an inline cache tag or null.
	 Answer if the updated literal is young.
	 mcpc is the address of the next instruction following either
	 the load of the method literal or the compare of the class tag."
	| object subject |
	object := backEnd literalBeforeFollowingAddress: mcpc.
	(objectRepresentation couldBeObject: object) ifFalse:
		[^false].
	subject := objectRepresentation remapOop: object.
	object ~= subject ifTrue:
		[backEnd storeLiteral: subject beforeFollowingAddress: mcpc.
		 codeModified := true].
	^objectMemory isYoungObject: subject