encoding - control
jA: target
	self assert: (target bitAnd: 3) = 0.
	^self jtype: J target: (target bitAnd: 16r0FFFFFFF) >> 2