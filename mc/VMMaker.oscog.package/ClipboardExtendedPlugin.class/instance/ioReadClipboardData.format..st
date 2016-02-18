io
ioReadClipboardData: clipboard format: format
	| clipboardAddress formatLength |
	<var: #clipboardAddress type: #'unsigned long'>
	self primitive: 'ioReadClipboardData' parameters: #(Oop String).
	clipboardAddress := interpreterProxy positiveMachineIntegerValueOf: clipboard.
	formatLength := interpreterProxy slotSizeOf: format cPtrAsOop.
	^ self sqPasteboardCopyItemFlavorData: clipboardAddress format: format formatLength: formatLength.
