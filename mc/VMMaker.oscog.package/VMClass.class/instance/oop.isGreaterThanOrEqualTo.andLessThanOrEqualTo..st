oop comparison
oop: anOop isGreaterThanOrEqualTo: baseOop andLessThanOrEqualTo: limitOop
	"Compare two oop values, treating them as object memory locations.
	Use #cCoerce:to: to ensure comparison of unsigned magnitudes. This
	method will be inlined during C translation."
	<inline: true>
	^(self cCoerce: anOop to: #usqInt) >= (self cCoerce: baseOop to: #usqInt)
	  and: [(self cCoerce: anOop to: #usqInt) <= (self cCoerce: limitOop to: #usqInt)]