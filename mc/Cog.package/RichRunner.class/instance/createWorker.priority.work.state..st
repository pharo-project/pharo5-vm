creation
createWorker: identity priority: priority work: work state: state 
    | data |
    data := RichWorkerTaskDataRecord new.
    self
	createTask: identity
	priority: priority
	work: work
	state: state
	function: 
	    [:work1 :word | | data1 |
	    data1 := word.
	    work1
		ifNil: [self wait]
		ifNotNil: 
		    [data1 destination: (HandlerA = data1 destination
			    ifTrue: [HandlerB]
			    ifFalse: [HandlerA]).
		    work1 identity: data1 destination.
		    work1 datum: 1.
		    1 to: 4 do: [ :i | 
			data1 count: data1 count + 1.
			data1 count > 26 ifTrue: [data1 count: 1].
			work1 data at: i put: $A asInteger + data1 count - 1].
		    self queuePacket: work1]]
	data: data