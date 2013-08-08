control primitives
primitiveInvokeObjectAsMethod
	"Primitive. 'Invoke' an object like a function, sending the special message 
		run: originalSelector with: arguments in: aReceiver.
	"
	<returnTypeC: #void>
	| runReceiver runArgs lookupClass |
	runArgs := objectMemory eeInstantiateClass: (objectMemory splObj: ClassArray) indexableSize: argumentCount.
	argumentCount - 1 to: 0 by: -1  do:
		[:i| objectMemory storePointerUnchecked: i ofObject: runArgs withValue: self popStack].

	runReceiver := self popStack.
	"setup send of newMethod run: originalSelector with: runArgs in: runReceiver"
	self push: newMethod. "newReceiver"
	self push: messageSelector "original selector".
	self push: runArgs.
	self push: runReceiver.

	"stack is clean here"

	messageSelector := objectMemory splObj: SelectorRunWithIn.
	argumentCount := 3.
	lookupClass := objectMemory fetchClassOf: newMethod.
	self findNewMethodInClass: lookupClass.
	self executeNewMethod.  "Recursive xeq affects successFlag"
	self initPrimCall