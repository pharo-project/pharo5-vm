abi
saveAndRestoreLinkRegAround: aBlock
	"If the processor's ABI includes a link register, generate instructions
	 to save and restore it around aBlock, which is assumed to generate code."
	<inline: true>
	^aBlock value