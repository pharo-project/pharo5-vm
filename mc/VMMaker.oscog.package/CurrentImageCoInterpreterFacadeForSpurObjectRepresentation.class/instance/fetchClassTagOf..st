accessing
fetchClassTagOf: anOop
	| class |
	self assert: SmalltalkImage current isRunningSpur.
	class := (self objectForOop: anOop) class.
	^SystemVersion current isPharo
		ifTrue: [class basicIdentityHash]
		ifFalse: [class identityHash]