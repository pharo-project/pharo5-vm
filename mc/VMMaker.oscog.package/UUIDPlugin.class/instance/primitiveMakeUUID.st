system primitives
primitiveMakeUUID
	| oop location |
	<export: true>
	<var: #location type: #'char*'>
	oop := interpreterProxy stackValue: 0.
	(interpreterProxy methodArgumentCount = 0
	 and: [(interpreterProxy isBytes: oop)
	 and: [(interpreterProxy byteSizeOf: oop) = 16]]) ifFalse:
		[^interpreterProxy primitiveFail].
	location := interpreterProxy firstIndexableField: oop.
	self cCode: [self MakeUUID: location]
		inSmalltalk:
			[| uuid |
			uuid := UUID new.
			1 to: 16 do:
				[:i| location at: i - 1 put: (uuid at: i)]].
	^oop