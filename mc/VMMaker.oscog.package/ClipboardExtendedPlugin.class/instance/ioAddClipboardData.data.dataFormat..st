io
ioAddClipboardData: clipboard data: data dataFormat: aFormat
	| clipboardAddress formatLength dataLength |
	<var: #clipboardAddress type: #'usqIntptr_t'>
	self primitive: 'ioAddClipboardData' parameters: #(Oop ByteArray String).

	clipboardAddress := interpreterProxy positiveMachineIntegerValueOf: clipboard.
	dataLength := interpreterProxy slotSizeOf: data cPtrAsOop.
	formatLength := interpreterProxy slotSizeOf: aFormat cPtrAsOop.

	self sqPasteboardPutItemFlavor: clipboardAddress data: data length: dataLength formatType: aFormat formatLength: formatLength.
