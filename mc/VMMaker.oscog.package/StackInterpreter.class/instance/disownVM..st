vm scheduling
disownVM: flags
	<api>
	<inline: false>
	"Release the VM to other threads and answer the current thread's index.

	 This is the entry-point for plugins and primitives that wish to release the VM while
	 performing some operation that may potentially block, and for callbacks returning
	 back to some blocking operation.  While this exists for the threaded FFI VM we use
	 it to reset newMethod and the argumentCount after a callback."
	self assert: ((objectMemory isIntegerObject: flags)
				and: [(objectMemory integerValueOf: flags)
						between: 0
						and: (self argumentCountOfMethodHeader: -1)]).
	self assert: primFailCode = 0.
	argumentCount := objectMemory integerValueOf: flags.
	newMethod := self popStack.
	self assert: ((objectMemory isOopCompiledMethod: newMethod)
				and: [(self argumentCountOf: newMethod) = argumentCount]).
	^0