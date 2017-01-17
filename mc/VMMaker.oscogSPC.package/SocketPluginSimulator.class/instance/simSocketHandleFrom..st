simulation support
simSocketHandleFrom: socketHandleCArray
	| simSocket |
	"SQSocket is typedef struct { int sessionID; int socketType; void *privateSocketPtr; } SQSocket"
	simSocket := ByteArray new: (self sizeof: #SQSocket).
	1 to: simSocket size do:
		[:i|
		simSocket at: i put: (socketHandleCArray at: i - 1)].
	^simSocket