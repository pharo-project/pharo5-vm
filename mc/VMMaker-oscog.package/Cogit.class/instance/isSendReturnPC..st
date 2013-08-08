jit - api
isSendReturnPC: retpc
	<api>
	"Answer if the instruction preceeding retpc is a call instruction."
	| target |
	(backEnd isCallPreceedingReturnPC: retpc) ifFalse:
		[^false].
	target := backEnd callTargetFromReturnAddress: retpc.
	^(target between: firstSend and: lastSend)
	   or: [target between: methodZoneBase and: methodZone freeStart]