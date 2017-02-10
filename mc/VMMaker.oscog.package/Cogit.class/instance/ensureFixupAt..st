compile abstract instructions
ensureFixupAt: targetPC
	"Make sure there's a flagged fixup at the target pc in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<returnTypeC: #'BytecodeFixup *'>
	| fixup |
	<var: #fixup type: #'BytecodeFixup *'>
	fixup := self fixupAt: targetPC.
	fixup notAFixup ifTrue:
		[fixup becomeFixup].
	fixup recordBcpc: bytecodePC.
	^fixup