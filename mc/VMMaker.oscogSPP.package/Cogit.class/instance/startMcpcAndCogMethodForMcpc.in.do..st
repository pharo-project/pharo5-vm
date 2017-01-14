disassembly
startMcpcAndCogMethodForMcpc: mcpc in: cogMethod do: aBinaryBlock
	"Evaluate aBinaryBlock with the startmcpc and method containing mcpc in cogMethod."
	<doNotGenerate>
	| startMcpc |
	startMcpc := ((self codeRangesFor: cogMethod)
					detect: [:range| range includes: mcpc]
					ifNone:
						[(self codeRangesFor: cogMethod)
							detect: [:range| range last + 1 = mcpc]
							ifNone: [^nil]]) first.
	^aBinaryBlock
		value: startMcpc
		value: (startMcpc = (cogMethod asInteger + (self sizeof: CogMethod))
					ifTrue: [cogMethod]
					ifFalse: [self cCoerceSimple: startMcpc - (self sizeof: CogBlockMethod)
								to: #'CogBlockMethod *'])