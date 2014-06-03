lines-wide
returnWideLineFill
	"Return the fill of the (wide) line - this method is called from a case."
	^(dispatchReturnValue := self wideLineFillOf: dispatchedValue).