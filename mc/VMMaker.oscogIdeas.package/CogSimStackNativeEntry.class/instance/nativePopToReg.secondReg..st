compile abstract instructions
nativePopToReg: reg secondReg: secondReg
	self assert: BytesPerWord = 4.
	spilled ifTrue: [
			cogit PopR: reg; PopR: secondReg
		]
		ifFalse: [
			type caseOf: {
				[SSConstantInt64]	-> [
					cogit MoveCq: (constantInt64 bitAnd: 16rFFFFFFFF) R: reg.
					cogit MoveCq: ((constantInt64 >> 32) bitAnd: 16rFFFFFFFF) R: secondReg.
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
			}
		].
