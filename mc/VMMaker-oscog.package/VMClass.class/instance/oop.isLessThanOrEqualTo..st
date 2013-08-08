oop comparison
oop: anOop isLessThanOrEqualTo: otherOop
	"Compare two oop values, treating them as object memory locations.
	Use #cCoerce:to: to ensure comparison of unsigned magnitudes. This
	method will be inlined during C translation."
	<inline: true>
	^(self cCoerce: anOop to: #usqInt)
		<= (self cCoerce: otherOop to: #usqInt)