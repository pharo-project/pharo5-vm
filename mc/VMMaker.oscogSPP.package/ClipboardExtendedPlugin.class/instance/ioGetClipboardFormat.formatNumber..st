io
ioGetClipboardFormat: clipboard formatNumber: formatNumber 
	| clipboardAddress itemCount |
	<var: #clipboardAddress type: #'usqIntptr_t'>
	self primitive: 'ioGetClipboardFormat' parameters: #(#Oop #SmallInteger ).
	clipboardAddress := interpreterProxy positiveMachineIntegerValueOf: clipboard.
	itemCount := self sqPasteboardGetItemCount: clipboardAddress.
	itemCount > 0
		ifTrue: [^ self sqPasteboardCopyItemFlavors: clipboardAddress itemNumber: formatNumber].
	^ interpreterProxy nilObject