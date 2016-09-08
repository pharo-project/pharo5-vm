interpreter access
instanceSizeOf: classObj
	<api>
	"Answer the number of slots in a class.  For example the instanceSizeOf: 
	 ClassPoint is 2, for the x & y slots. The instance size of non-pointer classes is 0."
	self assert: (coInterpreter addressCouldBeClassObj: classObj).

	^(self formatOfClass: classObj) bitAnd: self fixedFieldsOfClassFormatMask