primitive support
startOfData: oop "<Alien oop> ^<Integer>"
	"Answer the start of oop's data.  For direct aliens this is the address of
	 the second field.  For indirect and pointer aliens it is what the second field points to."
	<inline: true>
	^(self sizeField: oop) > 0
	 	ifTrue: [oop + interpreterProxy baseHeaderSize + interpreterProxy bytesPerOop]
		ifFalse: [self longAt: oop + interpreterProxy baseHeaderSize + interpreterProxy bytesPerOop]