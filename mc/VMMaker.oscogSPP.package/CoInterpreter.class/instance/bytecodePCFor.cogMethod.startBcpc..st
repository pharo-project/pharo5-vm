frame access
bytecodePCFor: theIP cogMethod: cogMethod startBcpc: startBcpc
	"Answer the mapping of the native pc theIP to a zero-relative bytecode pc.
	 See contextInstructionPointer:frame: for the explanation."
	<var: #cogMethod type: #'CogMethod *'>
	| cogMethodForIP mcpc |
	<inline: true>
	<var: #cogMethodForIP type: #'CogBlockMethod *'>
	self assert: theIP < 0.
	(theIP signedBitShift: -16) < -1 "See contextInstructionPointer:frame:"
		ifTrue:
			[cogMethodForIP := self cCoerceSimple: cogMethod asInteger - ((theIP signedBitShift: -16) * cogit blockAlignment)
									to: #'CogBlockMethod *'.
			 self assert: cogMethodForIP cmType = CMBlock.
			 self assert: cogMethodForIP cmHomeMethod = cogMethod.
			 mcpc := cogMethodForIP asInteger - theIP signedIntFromShort]
		ifFalse:
			[cogMethodForIP := self cCoerceSimple: cogMethod to: #'CogBlockMethod *'.
			 self assert: cogMethodForIP cmType = CMMethod.
			 mcpc := cogMethod asInteger - theIP.
			 "map any pcs in primitive code (i.e. return addresses for interpreter primitive calls) to the initial pc"
			 mcpc asUnsignedInteger < cogMethod stackCheckOffset ifTrue:
				[^startBcpc]].
	self assert: (mcpc between: cogMethod asInteger and: cogMethod asInteger + cogMethod blockSize).
	^cogit bytecodePCFor: mcpc startBcpc: startBcpc in: cogMethodForIP