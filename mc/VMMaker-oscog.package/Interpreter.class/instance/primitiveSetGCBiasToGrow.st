memory space primitives
primitiveSetGCBiasToGrow
	"Primitive. Indicate if the GC logic should have bias to grow"
	| flag |
	<export: true>
	flag := self stackIntegerValue: 0.
	successFlag ifTrue:[
		gcBiasToGrow := flag.
		self pop: argumentCount.
	].