scheduling
schedule
    currentTask := taskList. 
    [currentTask isNil]
	whileFalse: 
	    [currentTask isTaskHoldingOrWaiting
		ifTrue: [currentTask := currentTask link]
		ifFalse: 
		    [currentTaskIdentity := currentTask identity.
		    currentTask := currentTask runTask]]