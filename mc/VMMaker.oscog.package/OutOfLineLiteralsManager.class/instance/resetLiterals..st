initialization
resetLiterals: numLiteralsHint
	<inline: true>
	self cCode:
			[self me: literals ms: 0 et: literalsSize * (self sizeof: CogAbstractInstruction)]
		inSmalltalk:
			[0 to: literalsSize - 1 do: [:i| literals at: i put: nil]].
	firstOpcodeIndex := 1 << 16. "an impossibly high value"
	nextLiteralIndex := lastDumpedLiteralIndex := 0