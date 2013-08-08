garbage collection
checkMaybeObjRefAt: mcpc
	| maybeObject |
	maybeObject := backEnd literalBeforeFollowingAddress: mcpc.
	(objectRepresentation couldBeObject: maybeObject) ifFalse:
		[^true].
	^objectRepresentation checkValidObjectReference: maybeObject