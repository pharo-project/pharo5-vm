abstract instructions
genMemCopy: originalSourceReg to: originalDestReg constantSize: size
	| numbytes numwords sourceReg destReg countReg inst |

	"Get the abstract registers for ECX, EDI and ESI"
	sourceReg := ESI.
	destReg := EDI.
	countReg := ECX.

	"Put the source in ESI and the dest in EDI"
	inst := cogit Label.
	originalSourceReg ~= sourceReg ifTrue: [
		originalDestReg = sourceReg ifTrue: [
			cogit MoveR: originalDestReg R: TempReg.
		].
		cogit MoveR: originalSourceReg R: sourceReg.
	].

	originalDestReg ~= destReg ifTrue: [
		originalDestReg = sourceReg ifTrue: [
			cogit MoveR: TempReg R: destReg.
		] ifFalse: [
			cogit MoveR: originalDestReg R: destReg.
		]
	].

	"Store the count and clear the direction"
	cogit gen: CLD.

	"First copy the bytes"
	numbytes := size bitAnd: 16r03.
	numbytes > 0 ifTrue: [
		cogit MoveCq: numbytes R: countReg.
		cogit gen: REP.
		cogit gen: MOVSB.
	].

	"Now copy the words"
	numwords := size // 4.
	cogit MoveCq:  numwords R: countReg.
	cogit gen: REP.
	cogit gen: MOVSD.

