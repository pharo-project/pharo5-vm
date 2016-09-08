memory space primitives
primitiveSetGCBiasToGrow
	"Primitive. Indicate if the GC logic should have bias to grow"
	| flag |
	<export: true>
	<option: #SqueakV3ObjectMemory> "for now..."
	flag := self stackIntegerValue: 0.
	self successful ifTrue:[
		objectMemory gcBiasToGrow: flag.
		self pop: argumentCount.
	]