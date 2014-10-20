primitives
primitiveGetStringProperty
	"Primitive. Returns a string property for the session"

	| stringLen stringOop propID handle stringPtr oopPtr |
	<var: #stringPtr type: 'char *'>
	<var: #oopPtr type: 'char *'>
	<export: true>
	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	propID := interpreterProxy stackIntegerValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	interpreterProxy failed ifTrue:[^nil].
	stringPtr := self cCode: 'sqGetStringPropertySSL(handle, propID)' 
					inSmalltalk:[handle. propID. nil].
	interpreterProxy failed ifTrue:[^nil].
	stringPtr == nil ifTrue:[
		stringOop := interpreterProxy nilObject.
	] ifFalse:[
		stringLen := self strlen: stringPtr.
		stringOop := interpreterProxy 
			instantiateClass: (interpreterProxy classString)
			indexableSize: stringLen.
		oopPtr := interpreterProxy firstIndexableField: stringOop.
		0 to: stringLen-1 do:[:i| oopPtr at: i put: (stringPtr at: i)].
	].
	interpreterProxy 
		pop: interpreterProxy methodArgumentCount + 1
		thenPush: stringOop.
