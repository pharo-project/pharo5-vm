io
ioReadClipboardData: clipboard format: format
	| clipboardAddress formatLength |
	<var: #clipboardAddress type: #'usqIntptr_t'>
	self primitive: 'ioReadClipboardData' parameters: #(Oop String).
	clipboardAddress := interpreterProxy positiveMachineIntegerValueOf: clipboard.
	formatLength := interpreterProxy slotSizeOf: format cPtrAsOop.
	^ self sqPasteboardCopyItemFlavorData: clipboardAddress format: format formatLength: formatLength.
