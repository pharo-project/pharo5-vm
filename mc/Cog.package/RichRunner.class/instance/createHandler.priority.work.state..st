creation
createHandler: identity priority: priority work: work state: state 
    | data |
    data := RichHandlerTaskDataRecord new.
    self
	createTask: identity
	priority: priority
	work: work
	state: state
	function: 
	    [:work1 :word | | data1 workPacket count devicePacket |
	    data1 := word.
	    work1 
		ifNotNil: [WorkPacketKind == work1 kind 
		    ifTrue: [data1 workInAdd: work1]
		    ifFalse: [data1 deviceInAdd: work1]].
	    (workPacket := data1 workIn) 
		ifNil: [self wait]
		ifNotNil: 
		    [count := workPacket datum.
		    count > 4
			ifTrue: 
			    [data1 workIn: workPacket link.
			    self queuePacket: workPacket]
			ifFalse:
			    [(devicePacket := data1 deviceIn) 
				ifNil: [self wait]
				ifNotNil: 
				    [data1 deviceIn: devicePacket link.
				    devicePacket datum: (workPacket data at: count).
				    workPacket datum: count + 1.
				    self queuePacket: devicePacket]]]]
	data: data