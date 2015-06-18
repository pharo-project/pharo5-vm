initialization
allocateLiterals: initialNumLiterals
	<inline: true>
	| newLiterals newInst existingInst |
	<var: 'newInst' type: #'AbstractInstruction *'>
	<var: 'existingInst' type: #'AbstractInstruction *'>
	<var: 'newLiterals' type: #'AbstractInstruction *'>
	initialNumLiterals > literalsSize ifTrue:
		[newLiterals := self cCode:
								[self c: initialNumLiterals alloc: (self sizeof: CogAbstractInstruction)]
							inSmalltalk:
								[CArrayAccessor on: ((1 to: initialNumLiterals) collect: [:i| CogCompilerClass for: cogit])].
		 "Must copy across state (not using realloc, cuz...) and
		  must also update existing instructions to refer to the new ones...
		  It's either this or modify all generation routines to be able to retry
		  with more literals after running out of literals."
		 literals ifNotNil:
			[0 to: nextLiteralIndex - 1 do:
				[:i|
				existingInst := self literalInstructionAt: i.
				newInst := self addressOf: (newLiterals at: i).
				newInst cloneLiteralFrom: existingInst.
				self assert: existingInst dependent isNil.
				existingInst dependent: newInst].
			0 to: cogit getOpcodeIndex - 1 do:
				[:i|
				existingInst := cogit abstractInstructionAt: i.
				(existingInst dependent notNil
				 and: [existingInst dependent opcode = Literal]) ifTrue:
					[existingInst dependent: existingInst dependent dependent]]].
		 self cCode: [self free: literals] inSmalltalk: [].
		 literals := newLiterals.
		 literalsSize := initialNumLiterals]