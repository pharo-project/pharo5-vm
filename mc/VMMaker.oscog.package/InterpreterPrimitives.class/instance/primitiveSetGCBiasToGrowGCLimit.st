memory space primitives
primitiveSetGCBiasToGrowGCLimit
	"Primitive. If the GC logic has  bias to grow, set growth limit"
	| value |
	<export: true>
	<option: #SqueakV3ObjectMemory> "for now..."
	value := self stackIntegerValue: 0.
	self successful ifTrue:
		[objectMemory gcBiasToGrowGCLimit: value.
		 objectMemory gcBiasToGrowThreshold: objectMemory youngStart - objectMemory startOfMemory asInteger.
		 self pop: argumentCount]