encoding - control
jalA: target
	self assert: (target bitAnd: 3) = 0.
	^self jtype: JAL target: (target bitAnd: 16r0FFFFFFF) >> 2