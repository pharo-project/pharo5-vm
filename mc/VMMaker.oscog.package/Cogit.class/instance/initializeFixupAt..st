compile abstract instructions
initializeFixupAt: targetPC
	"Make sure there's a flagged fixup at the targetPC in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<returnTypeC: #'BytecodeFixup *'>
	(self fixupAt: targetPC) becomeFixup