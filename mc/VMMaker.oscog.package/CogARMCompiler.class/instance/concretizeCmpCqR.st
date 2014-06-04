generate machine code - concretize
concretizeCmpCqR
	"Will get inlined into concretizeAt: switch."
	"All other data operations write back their results. The write back register should be zero for CMP."
	<inline: true>
	| size |
	size := self concretizeDataOperationCqR: 16rA.
	machineCode at: size - 3 put: ((machineCode at: size -3) bitAnd: 16rFF).
	^size
