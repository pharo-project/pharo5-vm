primitives-other
primitiveInitializeBuffer
	| wbOop size |
	<export: true>
	<inline: false>
	interpreterProxy methodArgumentCount = 1
		ifFalse:[^interpreterProxy primitiveFail].
	wbOop := interpreterProxy stackObjectValue: 0.
	interpreterProxy failed ifTrue:[^nil].
	(interpreterProxy isWords: wbOop) 
		ifFalse:[^interpreterProxy primitiveFail].
	(size := interpreterProxy slotSizeOf: wbOop) < GWMinimalSize
		ifTrue:[^interpreterProxy primitiveFail].
	self workBufferPut: wbOop.
	objBuffer := workBuffer + GWHeaderSize.
	self magicNumberPut: GWMagicNumber.
	self wbSizePut: size.
	self wbTopPut: size.
	self statePut: GEStateUnlocked.
	self objStartPut: GWHeaderSize.
	self objUsedPut: 4.	"Dummy fill object"
	self objectTypeOf: 0 put: GEPrimitiveFill.
	self objectLengthOf: 0 put: 4.
	self objectIndexOf: 0 put: 0.
	self getStartPut: 0.
	self getUsedPut: 0.
	self aetStartPut: 0.
	self aetUsedPut: 0.
	self stopReasonPut: 0.
	self needsFlushPut: 0.
	self clipMinXPut: 0.
	self clipMaxXPut: 0.
	self clipMinYPut: 0.
	self clipMaxYPut: 0.
	self currentZPut: 0.
	self resetGraphicsEngineStats.
	self initEdgeTransform.
	self initColorTransform.
	interpreterProxy pop: 2.
	interpreterProxy push: wbOop.