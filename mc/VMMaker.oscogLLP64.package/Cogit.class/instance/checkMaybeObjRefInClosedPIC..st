garbage collection
checkMaybeObjRefInClosedPIC: maybeObject
	maybeObject = 0 ifTrue:
		[^true].
	(objectRepresentation couldBeObject: maybeObject) ifFalse:
		[^true].
	^objectRepresentation checkValidObjectReference: maybeObject