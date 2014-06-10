scheduling
addInput: packet checkPriority: oldTask
    input 
	ifNil: 
	    [input := packet.
	    packetPendingIV := true.
	    priority > oldTask priority ifTrue: [ ^ self ]]
	ifNotNil: 
	    [ input := self append: packet head: input ].
    ^ oldTask