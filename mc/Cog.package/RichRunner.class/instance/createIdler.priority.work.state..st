creation
createIdler: identity priority: priority work: work state: state 
    | data |
    data := RichIdleTaskDataRecord new.
    self
	createTask: identity
	priority: priority
	work: work
	state: state
	function: 
	    [:work1 :word | | data1 |
	    data1 := word.
	    data1 count: data1 count - 1.
	    0 = data1 count
		ifTrue: [self holdSelf]
		ifFalse:
		    [0 = (data1 control bitAnd: 1)
			ifTrue: 
			    [data1 control: data1 control // 2.
			    self release: DeviceA]
			ifFalse: 
			    [data1 control: (data1 control // 2 bitXor: 53256).
			    self release: DeviceB]]]
	data: data