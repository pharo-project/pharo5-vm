simulation support
getenv: aByteStringOrByteArray
	<doNotGenerate>
	<primitive: 'primitiveGetenv' module: '' error: ec>
	ec == #'bad argument' ifTrue:
		[aByteStringOrByteArray isString ifFalse:
			[^self getenv: aByteStringOrByteArray asString]].
	self primitiveFail