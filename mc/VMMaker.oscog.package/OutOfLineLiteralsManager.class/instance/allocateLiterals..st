initialization
allocateLiterals: initialNumLiterals
	<inline: true>
	initialNumLiterals > literalsSize ifTrue:
		[self cCode:
				[literals := self re: literals alloc: initialNumLiterals * (self sizeof: CogAbstractInstruction)]
			inSmalltalk:
				[| newLiterals |
				 newLiterals := Array new: initialNumLiterals.
				 literals ifNotNil:
					[:existingLiterals| newLiterals replaceFrom: 1 to: literalsSize with: existingLiterals object startingAt: 1].
				 literals := CArrayAccessor on: newLiterals].
		 literalsSize := initialNumLiterals]