primitives
primitiveDisplayFormX11
	"
	displayForm: aForm 
	display: d 
	window: window
	srcX: srcX 
	srcY: srcY 
	dstX: dstX 
	dstY: dstY 
	w: w 
	h: h
	

	XPutImage(display, d, gc, image, src_x, src_y, dest_x, dest_y, width, height)
	"
	<export: true>
 
	self ioDisplayFormX11: interpreterProxy. "call low-level C function"
	
	interpreterProxy failed ifFalse: [  interpreterProxy pop: 9 ].
