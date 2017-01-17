compile abstract instructions
nativeStoreToReg: reg secondReg: secondReg
	self assert: BytesPerWord = 4.
	"FIXME: Duplicated code with popToReg:secondReg:"
	type caseOf: {
		[SSBaseOffset]	-> [
				cogit MoveMw: offset r: register R: reg.
				cogit MoveMw: offset + 4 r: register R: secondReg.
			].
		[SSSpillInt64]	-> [
				cogit MoveMw: offset r: register R: reg.
				cogit MoveMw: offset + 4 r: registerSecond R: secondReg
			].
		[SSRegisterPair]	-> [
				cogit Label.
				reg ~= register ifTrue: [
					registerSecond = reg ifTrue: [
						cogit MoveR: registerSecond R: TempReg.
					].
					cogit MoveR: register R: reg
				].

				registerSecond ~= secondReg ifTrue: [
					registerSecond = reg ifTrue: [
						cogit MoveR: TempReg R: secondReg.
					] ifFalse: [
						cogit MoveR: registerSecond R: secondReg.
					]
				].
			].
		[SSConstantInt64]	-> [
			self MoveCq: (constantInt64 bitAnd: 16rFFFFFFFF) R: reg.
			self MoveCq: ((constantInt64 >> 32) bitAnd: 16rFFFFFFFF) R: secondReg.
		].
	}.
