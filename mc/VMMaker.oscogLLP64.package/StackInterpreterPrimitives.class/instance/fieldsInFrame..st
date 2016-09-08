object access primitives
fieldsInFrame: theFP
	<var: #theFP type: #'char *'>
	^CtxtTempFrameStart + (self stackPointerIndexForFrame: theFP)