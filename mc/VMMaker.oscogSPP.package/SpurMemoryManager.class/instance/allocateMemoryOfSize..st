testing
allocateMemoryOfSize: memoryBytes
	<doNotGenerate>
	| bytesPerElement |
	bytesPerElement := (self memoryClass basicNew: 0) bytesPerElement.
	memory := self memoryClass new: memoryBytes + bytesPerElement - 1 // bytesPerElement