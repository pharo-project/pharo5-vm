primitives - OS process access
primitiveReapChildProcess
	"Clean up after the death of a child, and answer an array with the pid and
	the exit status of the child process. Answer nil if the pidToHandle does not exist."

	| pidToHandle pidResult exitStatus resultArray arrayPtr pid status |
	<export: true>
	<var: 'exitStatus' type: 'int'>
	<var: 'pidResult' type: 'pid_t'>
	<var: 'arrayPtr' declareC: 'sqInt *arrayPtr'>
	exitStatus := 0.	"Force C code translator to declare the variable"
	pidToHandle := interpreterProxy stackIntegerValue: 0.
	pidResult := self cCode: 'waitpid ( pidToHandle, &exitStatus, WNOHANG )'
					inSmalltalk: [ exitStatus := -1 ].
	pidResult <= 0
		ifTrue: [ interpreterProxy pop: 2; push: interpreterProxy nilObject ]
		ifFalse: [ "Answer an array with pid and result status "
			pid := interpreterProxy integerObjectOf: pidResult.
			status := interpreterProxy integerObjectOf: exitStatus.
			resultArray := interpreterProxy
							instantiateClass: interpreterProxy classArray
							indexableSize: 2.
			arrayPtr := interpreterProxy firstIndexableField: resultArray.
			self cCode: 'arrayPtr[0] = pid'
				inSmalltalk: [resultArray at: 1 put: pidResult].
			self cCode: 'arrayPtr[1] = status'
				inSmalltalk: [resultArray at: 2 put: exitStatus].
			interpreterProxy pop: 2; push: resultArray ]
