inline cacheing
targetFromJTypeAtAddress: mcpc
	<var: #mcpc type: #usqInt>
	<returnTypeC: #usqInt>
	| targetLow |
	targetLow := (objectMemory longAt: mcpc) bitAnd: 16r3FFFFFF.
	"mcpc + 4: relative to delay slot not j"
	^((mcpc + 4) bitAnd: 16rF0000000) + (targetLow << 2) 