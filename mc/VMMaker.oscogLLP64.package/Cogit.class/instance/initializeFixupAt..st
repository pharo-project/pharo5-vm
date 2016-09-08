compile abstract instructions
initializeFixupAt: targetIndex
	"Make sure there's a flagged fixup at the targetIndex (pc relative to first pc) in fixups.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	<returnTypeC: #'BytecodeFixup *'>
	(self fixupAt: targetIndex) becomeFixup