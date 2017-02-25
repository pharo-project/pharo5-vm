simulation support
hostSocketHandleFromSimSocketHandle: socketHandleCArray
	"Answer the corresponding host socketHandle for the simulation socketHandle, or nil if none, failing the primitive."
	^simSocketToHostSocketMap
		at: (self simSocketHandleFrom: socketHandleCArray)
		ifAbsent: [interpreterProxy primitiveFail. nil]