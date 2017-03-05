compile abstract instructions
initializeFixupAt: targetPC
	"Make sure there's a flagged fixup at the targetPC in fixups.
	 These are the targets of backward branches.  A backward branch fixup's simStackPtr
	 needs to be set when generating the code for the bytecode at the targetPC.
	 Initially a fixup's target is just a flag.  Later on it is replaced with a proper instruction."
	| fixup |
	fixup := self fixupAt: targetPC.
	self initializeFixup: fixup