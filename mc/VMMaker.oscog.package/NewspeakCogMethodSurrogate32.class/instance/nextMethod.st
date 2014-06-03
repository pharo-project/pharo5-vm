accessing
nextMethod
	| v |
	^(v := memory unsignedLongAt: address + 21 + baseHeaderSize) ~= 0 ifTrue:
		[cogit cCoerceSimple: v to: #'CogMethod *']