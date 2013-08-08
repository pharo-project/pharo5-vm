callout support
ffiReturnStruct: longLongRet ofType: ffiRetClass in: calloutState
	<var: #longLongRet type: #usqLong>
	<var: #calloutState type: #'CalloutState *'>
	"Create a structure return value from an external function call.  The value as been stored in
	 alloca'ed space pointed to by the calloutState."
	<inline: true>
	self subclassResponsibility