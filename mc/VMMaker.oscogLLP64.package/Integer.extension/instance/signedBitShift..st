*VMMaker-interpreter simulator
signedBitShift: anInteger
	"For historical reasons Slang generates an unsigned shift from all of the shift operators >>, << & bitShift:.
	 These are too deeply entrenched to try and redefine the semantics.  So instead we provide a signed bitShift:
	 that signals to Slang that its argument should be cast to signed, not to unsigned, when being shifted."
	^self bitShift: anInteger