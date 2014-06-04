accessing
nextMethod
	| v |
	^(v := memory unsignedLongLongAt: address + 33 + baseHeaderSize) ~= 0 ifTrue:
		[cogit cCoerceSimple: v to: #'CogMethod *']