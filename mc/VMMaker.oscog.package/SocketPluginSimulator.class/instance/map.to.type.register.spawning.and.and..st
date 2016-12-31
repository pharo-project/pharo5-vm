simulation support
map: hostSocketHandle to: simSockPtr type: socketType register: semaphores spawning: blockOne and: blockTwo and: blockThree
	| simSocket |
	"SQSocket is typedef struct { int sessionID; int socketType; void *privateSocketPtr; } SQSocket"
	simSocket := ByteArray new: (self sizeof: #SQSocket).
	simSocket
		unsignedLongAt: 1 put: interpreterProxy getThisSessionID;
		unsignedLongAt: 5 put: socketType.
	simSocket size = 12
		ifTrue: [simSocket unsignedLongAt: 9 put: (fakeAddressCounter := fakeAddressCounter + 64)]
		ifFalse: [simSocket unsignedLongLongAt: 9 put: (fakeAddressCounter := fakeAddressCounter + 80)].
	self assert: ((interpreterProxy isBytes: simSockPtr cPtrAsOop)
				and: [(interpreterProxy numBytesOf: simSockPtr cPtrAsOop) = simSocket size]).
	1 to: simSocket size do:
		[:i| simSockPtr at: i - 1 put: (simSocket at: i)].
	self assert: (self simSocketHandleFrom: simSockPtr) = simSocket.
	openSocketHandles add: hostSocketHandle.
	hostSocketToSimSocketMap at: hostSocketHandle put: simSocket.
	simSocketToHostSocketMap at: simSocket put: hostSocketHandle.
	externalSemaphores addAll: semaphores.
	"N.B. These don't need registering.  Eventually they will end up
	 waiting on semaphores that have been unregistered, and hence
	 will get garbage collected, along with these processes."
	blockOne fork.
	blockTwo fork.
	blockThree fork