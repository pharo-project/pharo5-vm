abstract instructions
genMemCopy: originalSourceReg to: originalDestReg size: originalSize
	| spilledSize size sourceReg destReg countReg inst |

	"Get the abstract registers for ECX, EDI and ESI"
	sourceReg := ESI.
	destReg := EDI.
	countReg := ECX.

	"TODO: Avoid spilling"
	spilledSize := false.
	(originalSize = sourceReg or: [originalSize = destReg]) ifTrue: [
		cogit PushR: originalSize.
		spilledSize := true.
	].

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

	"Put the original size register in somewhere different than ECX"
	spilledSize ifTrue: [
		cogit PopR: TempReg.
		size := TempReg.
	] ifFalse: [
		originalSize = countReg ifTrue: [
			cogit MoveR: originalSize R: TempReg.
			size := TempReg.
		] ifFalse: [
			size := originalSize.
		]
	].

	cogit gen: CLD.

	"First copy the bytes"
	cogit MoveR: size R: countReg.
	cogit AndCq: 16r03 R: countReg.
	cogit gen: REP.
	cogit gen: MOVSB.

	"Now copy the words"
	cogit MoveR: size R: countReg.
	cogit LogicalShiftRightCq: 2 R: countReg.
	cogit gen: REP.
	cogit gen: MOVSD.

