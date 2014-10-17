instruction decoding
pushReceiverVariable: offset
	currentContext push: {#inst. offset + 1}