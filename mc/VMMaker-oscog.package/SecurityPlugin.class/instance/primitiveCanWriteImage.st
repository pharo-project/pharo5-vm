primitives
primitiveCanWriteImage
	<export: true>
	interpreterProxy pop: 1.
	interpreterProxy pushBool: (self cCode:'ioCanWriteImage()' inSmalltalk:[true])