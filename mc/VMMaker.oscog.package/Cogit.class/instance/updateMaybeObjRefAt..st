garbage collection
updateMaybeObjRefAt: mcpc
	"Update a potential object reference from a closed PIC.
	 This may be an object reference, an inline cache tag or null.
	 Answer if the updated literal is young."
	| object subject |
	object := backEnd literalBeforeFollowingAddress: mcpc.
	(objectRepresentation couldBeObject: object) ifFalse:
		[^false].
	subject := objectRepresentation remapOop: object.
	object ~= subject ifTrue:
		[backEnd storeLiteral: subject beforeFollowingAddress: mcpc.
		 codeModified := true].
	^objectMemory isYoungObject: subject