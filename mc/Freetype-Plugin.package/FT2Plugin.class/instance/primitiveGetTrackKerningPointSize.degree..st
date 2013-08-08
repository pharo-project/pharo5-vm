primitives-FT2Kerning
primitiveGetTrackKerningPointSize: pointSize degree: degree

"disabled becaus of yet implemented"
^interpreterProxy primitiveFail

"	| rcvr face result |
	self var: #face type: 'FT_Face'.	
	self var: #result type: 'FT_Fixed'.

	rcvr := self 
				primitive: 'primitiveGetTrackKerningPointSizeDegree'
				parameters: #(SmallInteger SmallInteger)
				receiver: #FT2Face.
	errorCode := 0.

	face := self ftHandleValueFromReceiver: rcvr.
	face isNil ifTrue: [^interpreterProxy primitiveFail].
	
	result := 0.
	errorCode := self cCode: 'FT_Get_Track_Kerning(face, pointSize, degree, &result);' inSmalltalk: [result := 0].
	errorCode = 0 ifFalse: [^interpreterProxy primitiveFail].
	
	^ interpreterProxy integerObjectOf: result.
	
"