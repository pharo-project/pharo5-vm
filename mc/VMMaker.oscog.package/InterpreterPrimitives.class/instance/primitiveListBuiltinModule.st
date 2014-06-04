plugin primitives
primitiveListBuiltinModule
	"Primitive. Return the n-th builtin module name."
	| moduleName index length nameOop |
	<var: #moduleName type: #'char *'>
	self methodArgumentCount = 1 ifFalse:[^self primitiveFail].
	index := self stackIntegerValue: 0.
	index <= 0 ifTrue:[^self primitiveFail].
	moduleName := self ioListBuiltinModule: index.
	moduleName == nil ifTrue:[
		self pop: 2. "arg+rcvr"
		^self push: objectMemory nilObject].
	length := self strlen: moduleName.
	nameOop := objectMemory instantiateClass: objectMemory classString indexableSize: length.
	0 to: length-1 do:[:i|
		objectMemory storeByte: i ofObject: nameOop withValue: (moduleName at: i)].
	self forceInterruptCheck.
	self pop: 2 thenPush: nameOop