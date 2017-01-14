debug printing
printAllStacks
	"Print all the stacks of all running processes, including those that are currently suspended."
	| oop proc ctx |
	proc := self fetchPointer: ActiveProcessIndex ofObject: self schedulerPointer.
	self printNameOfClass: (self fetchClassOf: proc) count: 5.
	self cr.
	self printCallStackOf: activeContext. "first the active context"
	oop := self firstObject.
	[self oop: oop isLessThan: endOfMemory] whileTrue:[
		(self fetchClassOf: oop) == self classSemaphore ifTrue:[
			proc := self fetchPointer: FirstLinkIndex ofObject: oop.
			[proc == self nilObject] whileFalse:[
				self cr.
				self printNameOfClass: (self fetchClassOf: proc) count: 5.
				self cr.
				ctx := self fetchPointer: SuspendedContextIndex ofObject: proc.
				ctx == self nilObject ifFalse:[self printCallStackOf: ctx].
				proc := self fetchPointer: NextLinkIndex ofObject: proc].
		].
		oop := self objectAfter: oop.
	].