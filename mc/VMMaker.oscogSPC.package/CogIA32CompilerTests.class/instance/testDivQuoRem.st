tests
testDivQuoRem
	"| failures ops |
	 failures := Set new.
	 [ops := (CogIA32CompilerTests new testDivQuoRem)]
		on: TestResult failure
		do: [:ex| | c |
			c := ex signalerContext.
			[c tempNames includes: 'op'] whileFalse:
				[c := c sender].
			failures add: (c namedTempAt: (c tempNames indexOf: 'op')).
			ex resume].
	 { ops size. failures size. ops asSortedCollection asArray. failures asSortedCollection asArray}"
	| map compiler memory ops |
	map := Dictionary new.
	compiler := self gen: nil.
	memory := ByteArray new: 4096 * 2.
	ops := Set new.
	CogIA32CompilerForTests dataRegistersWithAccessorsExcept: #(ebp esp) do:
		[:sreg :srget :srset|
		CogIA32CompilerForTests dataRegistersWithAccessorsExcept: { #ebp. #esp. srget } do:
			[:dreg :drget :drset|
			 | instructions op |
			CogIA32CompilerForTests dataRegistersWithAccessorsExcept: #(ebp esp) do:
				[:qreg :qrget :qrset| 
				CogIA32CompilerForTests dataRegistersWithAccessorsExcept: { #ebp. #esp. qrget } do:
					[:rreg :rrget :rrset|
					self resetGen.
					op := qrget, ' := ', drget, ' quo: ', srget, '. ', rrget, ' := ', drget, ' rem: ', srget.
					ops add: op.
					compiler genDivR: sreg R: dreg Quo: qreg Rem: rreg.
					instructions := self generateInstructions.
					memory atAllPut: 0; replaceFrom: 1 to: instructions size with: instructions startingAt: 1; at: instructions size + 1 put: self processor nopOpcode.
					#(-768 -456 -123 123 456 789)
						with: #(987 654 321 -321 -654 -987)
						do: [:dd :dv| "| calc |
							calc := ((dd quo: dv) bitAnd: 16rFFFFFFFF) hex, ' := ', (dd bitAnd: 16rFFFFFFFF) hex, ' quo: ', (dv bitAnd: 16rFFFFFFFF) hex, '. ', ((dd rem: dv) bitAnd: 16rFFFFFFFF) hex, ' := ', (dd bitAnd: 16rFFFFFFFF) hex, ' rem: ', (dv bitAnd: 16rFFFFFFFF) hex.
							calc := calc."
							"Transcript cr; cr; nextPutAll: op; cr; nextPutAll: calc; cr.
							 self processor
								disassembleFrom: 0 to: instructions size in: memory on: Transcript;
								printIntegerRegistersOn: Transcript."
							map
								at: #eax put: (self processor eax: 16rA5A5A5A5);
								at: #ebx put: (self processor ebx: 16rB5B5B5B5);
								at: #ecx put: (self processor ecx: 16rC5C5C5C5);
								at: #edx put: (self processor edx: 16rD5D5D5D5);
								at: #esi put: (self processor esi: 16r51515151);
								at: #edi put: (self processor edi: 16rD1D1D1D1);
								at: srget put: (self processor perform: srset with: dv signedIntToLong);
								at: drget put: (self processor perform: drset with: dd signedIntToLong).
							self processor esp: memory size; eip: 0.
							self shouldnt:
								[[self processor pc < instructions size] whileTrue:
									[self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2]]
								raise: Error.
							map
								at: qrget put: (dd quo: dv) signedIntToLong;
								at: rrget put: (dd rem: dv) signedIntToLong.
							map keysAndValuesDo:
								[:accessor :value|
								self assert: value = (self processor perform: accessor)]]]]]].
	^ops