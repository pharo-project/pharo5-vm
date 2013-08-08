platform
arg
	3 to: 5 do:
		[:i|
		(SmalltalkImage current getSystemAttribute: i) ifNotNil:
			[:aString|
			aString asInteger ifNotNil:
				[:arg| ^arg]]].
	^nil