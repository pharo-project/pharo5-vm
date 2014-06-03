garbage collection
checkMaybeObjRefAt: mcpc
	| maybeObject |
	maybeObject := backEnd literalBeforeFollowingAddress: mcpc.
	maybeObject = 0 ifTrue:
		[^true].
	(objectRepresentation couldBeObject: maybeObject) ifFalse:
		[^true].
	^objectRepresentation checkValidObjectReference: maybeObject