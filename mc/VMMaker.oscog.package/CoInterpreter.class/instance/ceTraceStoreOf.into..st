trampolines
ceTraceStoreOf: aValue into: anObject
	<api>
	"For assertion checking."
	self assert: ((objectMemory isImmediate: aValue) or: [objectMemory addressCouldBeObj: aValue]).
	self assert: (objectMemory addressCouldBeObj: anObject)