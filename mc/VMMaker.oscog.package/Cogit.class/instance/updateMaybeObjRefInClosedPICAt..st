garbage collection
updateMaybeObjRefInClosedPICAt: mcpc
	"Update a potential object reference from a closed PIC.
	 This may be an object reference, an inline cache tag or null.
	 Answer if the updated literal is young.
	'mcpc' refers to the jump/branch instruction at the end of
	each cpic case"
	| object subject |
	object := literalsManager objRefInClosedPICAt: mcpc.
	(objectRepresentation couldBeObject: object) ifFalse:
		[^false].
	subject := objectRepresentation remapOop: object.
	object ~= subject ifTrue:
		[literalsManager storeObjRef: subject inClosedPICAt: mcpc.
		 codeModified := true].
	^objectMemory isYoungObject: subject