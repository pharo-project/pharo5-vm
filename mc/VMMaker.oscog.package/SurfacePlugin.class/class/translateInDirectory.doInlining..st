translation
translateInDirectory: directory doInlining: inlineFlag
"handle a special case external file rather than normal generated code."
	| cg |
	self initialize.

	cg := self buildCodeGenerator.

	"We rely on the fake entry points implemented on the instance side to allow the export list to be accurate. Please update them if you change the code"
	^cg exportedPrimitiveNames asArray