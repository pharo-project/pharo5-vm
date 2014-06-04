io
ioGetClipboardFormat: clipboard formatNumber: formatNumber 
	| clipboardAddress itemCount |
	self primitive: 'ioGetClipboardFormat' parameters: #(#Oop #SmallInteger ).
	clipboardAddress := interpreterProxy positive32BitValueOf: clipboard.
	itemCount := self sqPasteboardGetItemCount: clipboardAddress.
	itemCount > 0
		ifTrue: [^ self sqPasteboardCopyItemFlavors: clipboardAddress itemNumber: formatNumber].
	^ interpreterProxy nilObject