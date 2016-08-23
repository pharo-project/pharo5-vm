header access
isObjImmutable: anOop
	<inline: true>
	^self cppIf: IMMUTABILITY
		ifTrue: [((self baseHeader: anOop) bitAnd: ImmutabilityBit hex) ~= 0]
		ifFalse: [false]