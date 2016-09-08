cryptography
primitiveARC4Transform
	"Perform an ARC4 transform of input.
	Arguments:
		buffer		<ByteArray> transformed data
		startIndex 	<Integer>	start of transform
		stopIndex	<Integer>	end of transform
		m			<ByteArray>	key stream data
		x			<Integer>	key state value
		y			<Integer>	key state value
	Return value:
		x@y - updated key state value
	"

	| y x mOop stopIndex startIndex bufOop bufSize buffer a m b mask ptOop xOop yOop |
	<export: true>
	<var: 'buffer' type: 'unsigned char *'>
	<var: 'm' type: 'unsigned char *'>

	interpreterProxy methodArgumentCount = 6
		ifFalse:[^interpreterProxy primitiveFail].
	"pick up arguments"
	y := interpreterProxy stackIntegerValue: 0.
	x := interpreterProxy stackIntegerValue: 1.
	mOop := interpreterProxy stackObjectValue: 2.
	stopIndex := interpreterProxy stackIntegerValue: 3.
	startIndex := interpreterProxy stackIntegerValue: 4.
	bufOop := interpreterProxy stackObjectValue: 5.
	interpreterProxy failed ifTrue:[^nil].
	((interpreterProxy isBytes: mOop) and:[interpreterProxy isBytes: bufOop])
		ifFalse:[^interpreterProxy primitiveFail].
	(interpreterProxy byteSizeOf: mOop) = 256
		ifFalse:[^interpreterProxy primitiveFail].
	bufSize := interpreterProxy byteSizeOf: bufOop.
	(startIndex > 0 and:[startIndex <= bufSize])
		ifFalse:[^interpreterProxy primitiveFail].
	(stopIndex >= startIndex and:[stopIndex <= bufSize])
		ifFalse:[^interpreterProxy primitiveFail].
	m := interpreterProxy firstIndexableField: mOop.
	buffer := interpreterProxy firstIndexableField: bufOop.
	startIndex-1 to: stopIndex-1 do:[:i|
		x := (x + 1) bitAnd: 255.
		a := m at: x.
		y := (y + a) bitAnd: 255.
		b := m at: y.
		m at: x put: b.
		m at: y put: a.
		mask := m at: ((a + b) bitAnd: 255).
		buffer at: i put: ((buffer at: i) bitXor: mask).
	].
	ptOop := interpreterProxy instantiateClass: interpreterProxy classPoint indexableSize: 0.
	interpreterProxy pushRemappableOop: ptOop.
	xOop := interpreterProxy positive32BitIntegerFor: x.
	interpreterProxy pushRemappableOop: xOop.
	yOop := interpreterProxy positive32BitIntegerFor: y.
	xOop := interpreterProxy popRemappableOop.
	ptOop := interpreterProxy popRemappableOop.
	interpreterProxy storePointer: 0 ofObject: ptOop withValue: xOop.
	interpreterProxy storePointer: 1 ofObject: ptOop withValue: yOop.
	interpreterProxy pop: interpreterProxy methodArgumentCount + 1.
	^interpreterProxy push: ptOop.
