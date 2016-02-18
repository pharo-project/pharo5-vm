io
ioCreateClipboard
	| clipboardAddress |
	self primitive: 'ioCreateClipboard' parameters: #().

	clipboardAddress := interpreterProxy positiveMachineIntegerFor: self sqCreateClipboard.

	^ clipboardAddress.