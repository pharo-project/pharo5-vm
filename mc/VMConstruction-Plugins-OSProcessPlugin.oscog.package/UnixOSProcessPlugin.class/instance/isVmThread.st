private - pthread
isVmThread
	"Answer true if this method is executing in the context of the pthread in
	which the interpreter executes."

	| thisThread |
	<var: 'thisThread' type: 'pthread_t'>
	thisThread := self cCode: 'pthread_self()' inSmalltalk: [0].
	^ self cCode: 'pthread_equal(thisThread, vmThread)' inSmalltalk: [true]
