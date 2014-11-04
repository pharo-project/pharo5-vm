accessing
stringArgumentAt: anOffset
	"To be inlined: common operations to obtain a string argument value at given stack offset.
	 The string returned is null-terminated, and alloca-d, so will be freed automatically"
	|  pointer index size alc |
	<inline: true>
	<var: 'alc' type: 'void *'>
	<returnTypeC: #'void *'>
	pointer := interpreterProxy stackValue: anOffset.
	(interpreterProxy isBytes: pointer)
		ifFalse: [^ interpreterProxy primitiveFail].
	index := interpreterProxy firstIndexableField: pointer.
	size := interpreterProxy byteSizeOf: pointer.
	alc := self alloca: (size + 1).
	self mem: alc se: 0 t: (size + 1).
	self mem: alc cp: index y: size.
	^alc.
