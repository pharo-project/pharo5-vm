private-support
startOfByteData: rcvr "<byte indexable oop> ^<Integer>"
	"Answer the start of rcvr's data, given that it is not an alien."
	<inline: true>
	^rcvr + interpreterProxy baseHeaderSize