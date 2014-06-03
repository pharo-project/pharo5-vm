creation
createDevice: identity priority: priority work: work state: state 
    | data |
    data := RichDeviceTaskDataRecord new.
    self
	createTask: identity
	priority: priority
	work: work
	state: state
	function: 
	    [:work1 :word | | data1 functionWork |
	    data1 := word.
	    functionWork := work1.
	    functionWork 
		ifNil:
		    [(functionWork := data1 pending) isNil
			ifTrue: [self wait]
			ifFalse: 
			    [data1 pending: nil.
			    self queuePacket: functionWork]]
		ifNotNil: 
		    [data1 pending: functionWork.
		    self holdSelf]]
	data: data