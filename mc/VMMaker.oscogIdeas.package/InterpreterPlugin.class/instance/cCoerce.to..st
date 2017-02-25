simulation
cCoerce: value to: cType
	"Type coercion for translation only; just return the value when running in Smalltalk.
	 This overrides the generic coercion method in VMClass.  For some reason we are the exception.
	 If we want that style of coercion we can send cCoerce:to: to interpreterProxy, not self."

	^value