UI
setBreakBlockFromString: aString
	| bString block |
	bString := aString withBlanksTrimmed.
	bString first ~= $[ ifTrue:
		[bString := '[:ct|', bString, ']'].
	block := [Compiler evaluate: bString for: self logged: false]
				on: Error
				do: [:ex|
					UIManager default warn: ex messageText.
					^self].
	cogit breakBlock: block