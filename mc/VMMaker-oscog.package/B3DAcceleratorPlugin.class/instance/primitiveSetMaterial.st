primitives-renderer
primitiveSetMaterial
	| material handle |
	<export: true>
	<inline: false>
	<var: #material type: 'void*'>

	interpreterProxy methodArgumentCount = 2
		ifFalse:[^interpreterProxy primitiveFail].
	material := self stackMaterialValue: 0.
	handle := interpreterProxy stackIntegerValue: 1.
	(self cCode:'b3dxLoadMaterial(handle, material)' inSmalltalk:[false])
		ifFalse:[^interpreterProxy primitiveFail].
	^interpreterProxy pop: 2. "args; return rcvr"