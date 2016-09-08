frame access
mframeHomeMethod: theFP
	"Answer the home method for a machine code frame.  From a block frame we find
	 the home method through the block's homeOffset field which is the delta to it.
	 In both cases we need to strip the isBlock and isContext flags from the method field."
	<api>
	<returnTypeC: #'CogMethod *'>
	<var: #theFP type: #'char *'>
	| methodField |
	methodField := self frameMethodField: theFP.
	(methodField bitAnd: MFMethodFlagIsBlockFlag) ~= 0 ifTrue:
		[^(self cCoerceSimple: (methodField bitAnd: MFMethodMask) to: #'CogBlockMethod *') cmHomeMethod].
	^self cCoerceSimple: (methodField bitAnd: MFMethodMask) to: #'CogMethod *'