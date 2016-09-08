stream support
fillBuffer
	| byte |
	[jsBitCount <= 16] whileTrue:[
		jsPosition < jsReadLimit ifFalse:[^jsBitCount].
		byte := jsCollection at: jsPosition.
		jsPosition := jsPosition + 1.
		byte = 16rFF ifTrue:["peek for 00"
			((jsPosition < jsReadLimit) and:[(jsCollection at: jsPosition) = 16r00]) ifFalse:[
				jsPosition := jsPosition - 1.
				^jsBitCount].
			jsPosition := jsPosition + 1].
		jsBitBuffer := (jsBitBuffer bitShift: 8) bitOr: byte.
		jsBitCount := jsBitCount + 8].
	^jsBitCount