primitives
primitiveVoltage
"primitive 220 

(the primitive name comes from it's number :) 

The primitive always fails. 
The only difference is the primitive fail code.

There are 2 different situations:

 - no NativeBoost code installed in method
 - the NativeBoost code is there, but since we're entered this primitive, it means that VM decided to execute this method via interpreter.

"
	<export: true >
	
	| methodObj len trailer codeOffset |
	
	methodObj  := self primitiveMethod.
		
	
	len := (objectMemory lengthOf: methodObj).
	trailer := (objectMemory byteAt: methodObj + BaseHeaderSize + len-1 ).
	(trailer bitAnd: 2r11111100) = 40 " Native code trailer id "
		ifFalse: [ ^ self primitiveFailFor:  502 " ErrNoNativeCodeInMethod" ].

	^ self primitiveFailFor: 505 "ErrRunningViaInterpreter"