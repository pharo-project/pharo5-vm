scheduling
runTask
    | message |
    self isWaitingWithPacket
	ifTrue: 
	    [message := input.
	    input := message link.
	    input 
		ifNil: [self running]
		ifNotNil: [self packetPending]]
	ifFalse: [message := nil].
    ^ function value: message value: handle