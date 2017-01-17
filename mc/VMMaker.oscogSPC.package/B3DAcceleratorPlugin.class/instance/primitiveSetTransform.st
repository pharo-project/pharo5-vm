primitives-renderer
primitiveSetTransform
	"Transform an entire vertex buffer using the supplied modelview and projection matrix."
	| projectionMatrix modelViewMatrix handle |
	<export: true>
	<inline: false>
	<var: #projectionMatrix declareC:'float *projectionMatrix'>
	<var: #modelViewMatrix declareC:'float *modelViewMatrix'>

	interpreterProxy methodArgumentCount = 3
		ifFalse:[^interpreterProxy primitiveFail].

	projectionMatrix := self stackMatrix: 0.
	modelViewMatrix := self stackMatrix: 1.
	handle := interpreterProxy stackIntegerValue: 2.
	interpreterProxy failed ifTrue:[^nil].
	self cCode: 'b3dxSetTransform(handle, modelViewMatrix, projectionMatrix)'.
	^interpreterProxy pop: 3. "Leave rcvr on stack"