compiled methods
literal: offset ofMethod: methodPointer put: oop
	<option: #SpurMemoryManager>
	<inline: true>
	objectMemory storePointer: offset + LiteralStart ofObject: methodPointer withValue: oop
