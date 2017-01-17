gc -- compaction
headerWhileForwardingOf: oop
	"Answer the header of the argument even though
	 it may have its header word in a forwarding block."
	| header fwdBlock |
	<inline: true>
	header := self longAt: oop.
	(header bitAnd: MarkBit) ~= 0 ifTrue:
		["oop is forwarded; get its real header from its forwarding table entry"
		 fwdBlock := (header bitAnd: AllButMarkBitAndTypeMask) << 1.
		 self assert: (self fwdBlockValid: fwdBlock).
		 header := self longAt: fwdBlock + self wordSize].
	^header