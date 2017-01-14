oop/chunk conversion
extraHeaderBytes: oopOrChunk
	"Return the number of extra bytes used by the given object's header."
	"Warning: This method should not be used during marking, when the header type bits of an object may be incorrect."

	"JMM should be an array lookup!" 
	<inline: true>
	^ headerTypeBytes at: (self headerType: oopOrChunk).