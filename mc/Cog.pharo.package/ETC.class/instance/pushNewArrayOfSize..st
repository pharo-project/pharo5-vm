instruction decoding
pushNewArrayOfSize: numElements
	currentContext pushNewArrayOfSize: numElements.
	scanner willStorePop ifTrue:
		[topIsVector := true.
		 scanner interpretNextInstructionFor: self.
		 topIsVector := false]