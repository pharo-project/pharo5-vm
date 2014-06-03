memory space primitives
primitiveSetGCBiasToGrowGCLimit
	"Primitive. If the GC logic has  bias to grow, set growth limit"
	| value |
	<export: true>
	value := self stackIntegerValue: 0.
	successFlag ifTrue:[
		gcBiasToGrowGCLimit := value.
		gcBiasToGrowThreshold := youngStart - (self cCoerce: memory to: 'int').
		self pop: argumentCount.
	].