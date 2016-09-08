gc -- compaction
isImmutableWhileForwarding: oop 
	"The given object may have its header word in a forwarding block. Find  
	the value of the isImmutable flag in the object in spite of this obstacle. "
	| header fwdBlock |
	<inline: true>
	header := self longAt: oop.
	(header bitAnd: MarkBit) ~= 0 ifTrue:
		["oop is forwarded; get its real header from its forwarding table entry"
		fwdBlock := (header bitAnd: AllButMarkBitAndTypeMask) << 1.
		DoAssertionChecks ifTrue:
			[self fwdBlockValidate: fwdBlock].
		header := self longAt: fwdBlock + self wordSize].
	^(header bitAnd: ImmutabilityBit) ~= 0