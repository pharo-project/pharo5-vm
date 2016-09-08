private-support
startOfData: rcvr "<Alien oop>" withSize: sizeField "<Integer> ^<Integer>"
	"Answer the start of rcvr's data.  For direct aliens this is the address of
	 the second field.  For indirect and pointer aliens it is what the second field points to."
	<inline: true>
	^sizeField > 0
	 	ifTrue: [rcvr + interpreterProxy baseHeaderSize + interpreterProxy bytesPerOop]
		ifFalse: [self longAt: rcvr + interpreterProxy baseHeaderSize + interpreterProxy bytesPerOop]