gc -- compaction
updatePointersInRangeFrom: memStart to: memEnd 
	"update pointers in the given memory range"
	| oop |
	<inline: false>
	oop := self oopFromChunk: memStart.
	[self oop: oop isLessThan: memEnd]
		whileTrue: [(self isFreeObject: oop)
				ifFalse: [self remapFieldsAndClassOf: oop].
			oop := self objectAfterWhileForwarding: oop]