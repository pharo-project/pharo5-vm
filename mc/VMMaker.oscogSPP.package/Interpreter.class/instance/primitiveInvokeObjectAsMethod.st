control primitives
primitiveInvokeObjectAsMethod
	"Primitive. 'Invoke' an object like a function, sending the special message 
		run: originalSelector with: arguments in: aReceiver.
	"
	| runSelector runReceiver runArgs newReceiver lookupClass |
	runArgs := self instantiateClass: (self splObj: ClassArray) indexableSize: argumentCount.
	self beRootIfOld: runArgs. "do we really need this?"
	self transfer: argumentCount from: stackPointer - ((argumentCount - 1) * self wordSize) to: runArgs + self baseHeaderSize.

	runSelector := messageSelector.
	runReceiver := self stackValue: argumentCount.
	self pop: argumentCount+1.

	"stack is clean here"

	newReceiver := newMethod.
	messageSelector := self splObj: SelectorRunWithIn.
	argumentCount := 3.

	self push: newReceiver.
	self push: runSelector.
	self push: runArgs.
	self push: runReceiver.

	lookupClass := self fetchClassOf: newReceiver.
	self findNewMethodInClass: lookupClass.
	self executeNewMethod.  "Recursive xeq affects successFlag"
	successFlag := true.
