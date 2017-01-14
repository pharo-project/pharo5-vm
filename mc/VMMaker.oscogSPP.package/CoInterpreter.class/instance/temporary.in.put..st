internal interpreter access
temporary: offset in: theFP put: valueOop
	<inline: true>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [self mtemporary: offset in: theFP put: valueOop]
		ifFalse: [self itemporary: offset in: theFP put: valueOop]