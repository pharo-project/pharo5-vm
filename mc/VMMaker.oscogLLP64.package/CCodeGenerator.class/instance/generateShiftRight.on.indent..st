C translation
generateShiftRight: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	| type isUnsigned mustCastBackToSigned mustCastToUnsigned |
	"If the variable is a 64-bit type then don't cast it to usqInt (typically a 32-bit type)"
	type := self typeFor: msgNode receiver in: currentMethod.
	isUnsigned := type first = $u.
	mustCastToUnsigned := isUnsigned not.
	mustCastBackToSigned := false "isUnsigned not". "FOR COMPATIBILITY WITH OLDER BEHAVIOUR, THIS MUST BE SO..."
	
	"If not unsigned, cast it to unsigned, and eventually cast the result back to original type."
	mustCastBackToSigned ifTrue:
		[aStream nextPut: $(; nextPut: $(; nextPutAll: type; nextPut: $)].
	mustCastToUnsigned ifTrue: 
		[aStream nextPut: $(; nextPut: $(; nextPutAll: (self unsignedTypeForIntegralType: type); nextPut: $)].
	 self emitCExpression: msgNode receiver on: aStream indent: level.
	mustCastToUnsigned ifTrue:
		[aStream nextPut: $)].
	aStream nextPutAll: ' >> '.
	self emitCExpression: msgNode args first on: aStream indent: level.
	mustCastBackToSigned ifTrue:
		[aStream nextPut: $)]