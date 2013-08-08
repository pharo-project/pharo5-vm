header access
isObjMutable: anOop
	<inline: true>
	^(self isObjImmutable: anOop) not