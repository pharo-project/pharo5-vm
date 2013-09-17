accessing
nextMethod
	| v |
	^(v := memory unsignedLongAt: address + 25) ~= 0 ifTrue:
		[cogit cCoerceSimple: v to: #'CogMethod *']