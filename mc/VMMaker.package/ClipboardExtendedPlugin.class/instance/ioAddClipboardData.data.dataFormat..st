io
ioAddClipboardData: clipboard data: data dataFormat: aFormat
| clipboardAddress formatLength dataLength |
self primitive: 'ioAddClipboardData' parameters: #(Oop ByteArray String).

clipboardAddress := interpreterProxy positive32BitValueOf: clipboard.

dataLength := interpreterProxy slotSizeOf: data cPtrAsOop.
formatLength := interpreterProxy slotSizeOf: aFormat cPtrAsOop.

self sqPasteboardPutItemFlavor: clipboardAddress data: data length: dataLength formatType: aFormat formatLength: formatLength.
