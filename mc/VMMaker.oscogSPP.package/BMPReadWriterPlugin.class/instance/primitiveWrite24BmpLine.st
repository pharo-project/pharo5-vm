primitives
primitiveWrite24BmpLine

	| width formBitsIndex formBitsOop pixelLineOop formBitsSize formBits pixelLineSize pixelLine |
	<export: true>
	<inline: false>
	<var: #formBits type: 'unsigned int *'>
	<var: #pixelLine type: 'unsigned char *'>
	interpreterProxy methodArgumentCount = 4 
		ifFalse:[^interpreterProxy primitiveFail].
	width := interpreterProxy stackIntegerValue: 0.
	width <= 0 ifTrue:[^interpreterProxy primitiveFail].
	formBitsIndex := interpreterProxy stackIntegerValue: 1.
	formBitsOop := interpreterProxy stackObjectValue: 2.
	pixelLineOop := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: formBitsOop) 
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy isBytes: pixelLineOop)
		ifFalse:[^interpreterProxy primitiveFail].
	formBitsSize := interpreterProxy slotSizeOf: formBitsOop.
	formBits := interpreterProxy firstIndexableField: formBitsOop.
	pixelLineSize := interpreterProxy slotSizeOf: pixelLineOop.
	pixelLine := interpreterProxy firstIndexableField: pixelLineOop.

	(formBitsIndex + width <= formBitsSize and:[width*3 <= pixelLineSize])
		ifFalse:[^interpreterProxy primitiveFail].

	"do the actual work. Read 32 bit at a time from formBits, and store the low order 24 bits 
	or each word into pixelLine in little endian order."

	self cCode:'
	formBits += formBitsIndex-1;

	while(width--) {
		unsigned int rgb;
		rgb = *formBits++;
		(*pixelLine++) = (rgb      ) & 0xFF;
		(*pixelLine++) = (rgb >> 8 ) & 0xFF;
		(*pixelLine++) = (rgb >> 16) & 0xFF;
	}

	' inSmalltalk:[formBits. pixelLine. ^interpreterProxy primitiveFail].
	interpreterProxy pop: 4. "args"
