tests
testMul
	"CogX64CompilerTests new setUp testMul"
	| map compiler memory |
	map := Dictionary new.
	compiler := self gen: nil.
	memory := ByteArray new: 1024.
	self concreteCompilerClass dataRegistersWithAccessorsExcept: #(rbp rsp) do:
		[:sreg :srget :srset|
		self concreteCompilerClass dataRegistersWithAccessorsExcept: { #rbp. #rsp. srget } do:
			[:dreg :drget :drset| | instructions |
			self resetGen.
			compiler genMulR: sreg R: dreg.
			instructions := self generateInstructions.
			memory atAllPut: 0; replaceFrom: 1 to: instructions size with: instructions startingAt: 1.
			#(-768 -456 -123 123 456 789)
				with: #(987 654 321 -321 -654 -987)
				do: [:a :b|
					"self processor
						disassembleFrom: 0 to: instructions size in: memory on: Transcript;
						printIntegerRegistersOn: Transcript."
					map
						at: #rax put: (self processor rax: 16rA5A5A5A5);
						at: #rbx put: (self processor rbx: 16rB5B5B5B5);
						at: #rcx put: (self processor rcx: 16rC5C5C5C5);
						at: #rdx put: (self processor rdx: 16rD5D5D5D5);
						at: #rsi put: (self processor rsi: 16r51515151);
						at: #rdi put: (self processor rdi: 16rD1D1D1D1);
								at: srget put: (self processor perform: srset with: (self processor convertIntegerToInternal: b));
								at: drget put: (self processor perform: drset with: (self processor convertIntegerToInternal: a)).
					self processor rsp: memory size; rip: 0.
					self shouldnt:
						[[self processor pc < instructions size] whileTrue:
							[self processor singleStepIn: memory]]
						raise: Error.
					map at: drget put: (self processor convertIntegerToInternal: (a * b)).
					map keysAndValuesDo:
						[:accessor :value|
						self assert: value = (self processor perform: accessor)]]]]