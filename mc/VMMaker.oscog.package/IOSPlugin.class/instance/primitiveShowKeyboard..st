primitives
primitiveShowKeyboard: showBoolean
	<export: true>
	self primitive: #primitiveShowKeyboard parameters: #(Boolean).
	self sqShowKeyboard: showBoolean.