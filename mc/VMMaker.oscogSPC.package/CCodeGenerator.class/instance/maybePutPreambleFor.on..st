C code generator
maybePutPreambleFor: aClass on: aStream
	aClass preambleCCode ifNotNil:
		[:preamble| | actualClass |
		 actualClass := aClass class whichClassIncludesSelector: #preambleCCode.
		 aStream
			ensureCr; cr;
			nextPutAll: '/* '; print: actualClass; nextPutAll: '>>preambleCCode */'; cr;
			nextPutAll: preamble; cr;
			nextPutAll: '/* end '; print: actualClass; nextPutAll: '>>preambleCCode */'; cr]