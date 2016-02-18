primitive generators
genPrimReturn
	"Generate a return that cuts back the stack to remove the receiver
	 and arguments after an invocation of a primitive with nargs arguments.
	 Since all primitives that succeed in the normal way (i.e. don't execute a
	 method as do genPrimitiveClosureValue and genPrimitivePerform) take only
	 register arguments, there is nothing to do."
	<inline: true>
	self assert: methodOrBlockNumArgs <= self numRegArgs.
	^self RetN: 0