primitives - OS process access
primitiveGetSession
	"Answer the unique session identifier for this Smalltalk instance running in this
	OS process. The C integer value is coerced into a Smalltalk ByteArray to preserve
	the full range of possible values."

	| sessionOop sessionByteArrayPointer thisSessionID sessionIDSize |
	<export: true>
	<var: 'sessionByteArrayPointer' declareC: 'unsigned char *sessionByteArrayPointer'>
	<var: 'copyByteArrayPointer' declareC: 'unsigned char *copyByteArrayPointer'>
	<var: 'thisSessionID' type: 'SESSIONIDENTIFIERTYPE'>
	thisSessionID := self getThisSessionIdentifier.
	sessionIDSize := self sizeof: thisSessionID.
	sessionOop := interpreterProxy
		instantiateClass: interpreterProxy
		classByteArray
		indexableSize: sessionIDSize.
	sessionByteArrayPointer := interpreterProxy arrayValueOf: sessionOop.
	thisSessionID isNil ifTrue:
		[^ interpreterProxy primitiveFail].	"The session ID is not permitted to be zero"
	self copyBytesFrom: (self cCode: '(unsigned char *)&thisSessionID'
							inSmalltalk: [thisSessionID asByteArray asString])
		to: sessionByteArrayPointer
		length: sessionIDSize.
	interpreterProxy pop: 1 thenPush: sessionOop
