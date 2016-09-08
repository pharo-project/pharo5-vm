interpreter shell
internalExecuteNewMethod
"Override the Interpreter version to trap cached external prims.
These have a 'prim index' of 1000 + the externalPrimitiveTableIndex normally used"
	primitiveIndex < 1000 ifTrue:[^super internalExecuteNewMethod].
	self externalizeIPandSP.
	self callExternalPrimitive: (externalPrimitiveTable at: primitiveIndex - 1001).
	self internalizeIPandSP