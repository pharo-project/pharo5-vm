creation
createTask: identity priority: priority work: work state: state function: aBlock data: data 
    | t |
    t := RichTaskControlBlock
		link: taskList
		create: identity
		priority: priority
		initialWorkQueue: work
		initialState: state
		function: aBlock
		privateData: data.
    taskList := t.
    taskTable at: identity put: t