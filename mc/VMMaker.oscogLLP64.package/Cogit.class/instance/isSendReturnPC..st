jit - api
isSendReturnPC: retpc
	<api>
	"Answer if the instruction preceding retpc is a call instruction."
	| target |
	(backEnd isCallPrecedingReturnPC: retpc) ifFalse:
		[^false].
	target := backEnd callTargetFromReturnAddress: retpc.
	^(target between: firstSend and: lastSend)
	   or: [target between: methodZoneBase and: methodZone freeStart]