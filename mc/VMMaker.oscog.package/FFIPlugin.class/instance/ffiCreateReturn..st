callout support
ffiCreateReturn: retVal
	"Generic callout support. Create an atomic return value from an external function call"
	| atomicType retOop oop |
	<inline: true>
	interpreterProxy failed ifTrue:[^nil].
	atomicType := self atomicTypeOf: ffiRetHeader.
	"void returns self"
	atomicType <= FFITypeVoid ifTrue:[
		^interpreterProxy pop: interpreterProxy methodArgumentCount].
	"everything else returns value"
	interpreterProxy pop: 
		interpreterProxy methodArgumentCount+1.
	interpreterProxy pushRemappableOop: ffiRetClass.
	retOop := self ffiCreateReturnOop: retVal.
	ffiRetClass := interpreterProxy popRemappableOop.
	ffiRetClass == interpreterProxy nilObject ifTrue:[
		"Just return oop"
		^interpreterProxy push: retOop].
	"Otherwise create an instance of external structure and store the return oop"
	interpreterProxy pushRemappableOop: retOop.
	retOop := interpreterProxy instantiateClass: ffiRetClass indexableSize: 0.
	oop := interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 0 ofObject: retOop withValue: oop.
	^interpreterProxy push: retOop.