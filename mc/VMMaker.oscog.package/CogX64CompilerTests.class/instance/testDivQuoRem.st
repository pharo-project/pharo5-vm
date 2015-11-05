tests
testDivQuoRem
	"| failures ops |
	 failures := Set new.
	 [ops := (CogX64CompilerTests new testDivQuoRem)]
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
	self concreteCompilerClass dataRegistersWithAccessorsExcept: #(rbp rsp) do:
		[:sreg :srget :srset|
		self concreteCompilerClass dataRegistersWithAccessorsExcept: { #rbp. #rsp. srget } do:
			[:dreg :drget :drset|
			 | instructions op |
			self concreteCompilerClass dataRegistersWithAccessorsExcept: #(rbp rsp) do:
				[:qreg :qrget :qrset| 
				self concreteCompilerClass dataRegistersWithAccessorsExcept: { #rbp. #rsp. qrget } do:
					[:rreg :rrget :rrset|
					self resetGen.
					op := qrget, ' := ', drget, ' quo: ', srget, '. ', rrget, ' := ', drget, ' rem: ', srget.
					ops add: op.
					compiler genDivR: sreg R: dreg Quo: qreg Rem: rreg.
					instructions := self generateInstructions.
					memory atAllPut: 0; replaceFrom: 1 to: instructions size with: instructions startingAt: 1; at: instructions size + 1 put: self processor nopOpcode.
					#(-768 -456 -123 123 456 789)
						with: #(987 654 321 -321 -654 -987)
						do: [:dd :dv| "| calc mask |
							mask := 16rFFFFFFFFFFFFFFFF.
							calc := ((dd quo: dv) bitAnd: mask) hex, ' := ', (dd bitAnd: mask) hex, ' quo: ', (dv bitAnd: mask) hex, '. ', ((dd rem: dv) bitAnd: mask) hex, ' := ', (dd bitAnd: mask) hex, ' rem: ', (dv bitAnd: mask) hex.
							calc := calc."
							"Transcript cr; cr; nextPutAll: op; cr; nextPutAll: calc; cr.
							 self processor
								disassembleFrom: 0 to: instructions size in: memory on: Transcript;
								printIntegerRegistersOn: Transcript."
							map
								at: #rax put: (self processor rax: 16rA5A5A5A5);
								at: #rbx put: (self processor rbx: 16rB5B5B5B5);
								at: #rcx put: (self processor rcx: 16rC5C5C5C5);
								at: #rdx put: (self processor rdx: 16rD5D5D5D5);
								at: #rsi put: (self processor rsi: 16r51515151);
								at: #rdi put: (self processor rdi: 16rD1D1D1D1);
								at: srget put: (self processor perform: srset with: (self processor convertIntegerToInternal: dv));
								at: drget put: (self processor perform: drset with: (self processor convertIntegerToInternal: dd)).
							self processor rsp: memory size; rip: 0.
							self shouldnt:
								[[self processor pc < instructions size] whileTrue:
									[self processor singleStepIn: memory readExecuteOnlyBelow: memory size / 2]]
								raise: Error.
							map
								at: qrget put: (self processor convertIntegerToInternal: (dd quo: dv));
								at: rrget put: (self processor convertIntegerToInternal: (dd rem: dv)).
							map keysAndValuesDo:
								[:accessor :value|
								self assert: value equals: (self processor perform: accessor)]]]]]].
	^ops