callout support
ffiReturnCStringFrom: cPointer
	"Create a Smalltalk string from a zero terminated C string"
	| strLen strOop cString strPtr |
	<var: #cString type: #'char *'>
	<var: #strPtr type: #'char *'>
	cPointer = nil ifTrue:[
		^interpreterProxy methodReturnValue: interpreterProxy nilObject]. "nil always returns as nil"
	cString := self cCoerce: cPointer to:'char *'.
	strLen := 0.
	[(cString at: strLen) = 0] whileFalse:[strLen := strLen+1].
	strOop := interpreterProxy 
				instantiateClass: interpreterProxy classString 
				indexableSize: strLen.
	strPtr := interpreterProxy firstIndexableField: strOop.
	0 to: strLen-1 do:[:i| strPtr at: i put: (cString at: i)].
	^interpreterProxy methodReturnValue: strOop