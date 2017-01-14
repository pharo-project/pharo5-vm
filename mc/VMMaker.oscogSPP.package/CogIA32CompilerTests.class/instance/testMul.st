tests
testMul
	"CogIA32CompilerTests new setUp testMul"
	| map compiler memory |
	map := Dictionary new.
	compiler := self gen: nil.
	memory := ByteArray new: 1024.
	CogIA32CompilerForTests dataRegistersWithAccessorsExcept: #(ebp esp) do:
		[:sreg :srget :srset|
		CogIA32CompilerForTests dataRegistersWithAccessorsExcept: { #ebp. #esp. srget } do:
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
						at: #eax put: (self processor eax: 16rA5A5A5A5);
						at: #ebx put: (self processor ebx: 16rB5B5B5B5);
						at: #ecx put: (self processor ecx: 16rC5C5C5C5);
						at: #edx put: (self processor edx: 16rD5D5D5D5);
						at: #esi put: (self processor esi: 16r51515151);
						at: #edi put: (self processor edi: 16rD1D1D1D1);
						at: srget put: (self processor perform: srset with: b signedIntToLong);
						at: drget put: (self processor perform: drset with: a signedIntToLong).
					self processor esp: memory size; eip: 0.
					self shouldnt:
						[[self processor pc < instructions size] whileTrue:
							[self processor singleStepIn: memory]]
						raise: Error.
					map at: drget put: (a * b) signedIntToLong.
					map keysAndValuesDo:
						[:accessor :value|
						self assert: value = (self processor perform: accessor)]]]]