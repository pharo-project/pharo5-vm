printing
printDecodeMethodHeaderOop: methodHeaderOop
	self printOopShort: methodHeaderOop.
	(self methodHeaderHasPrimitive: methodHeaderOop) ifTrue:
		[self print: ' hasPrim'].
	(self methodHeaderIndicatesLargeFrame: methodHeaderOop) ifTrue:
		[self print: ' largeFrame'].
	(SistaVM and: [self isOptimizedMethodHeader: methodHeaderOop]) ifTrue:
		[self print: ' optimized'].
	(MULTIPLEBYTECODESETS and: [objectMemory integerValueOf: methodHeaderOop]) < 0 ifTrue:
		[self print: ' altSet'].
	NewspeakVM ifTrue:
		[| s |
		s := (self accessModifierOfMethodHeader: methodHeaderOop) caseOf: {
						[0] -> [' public'].
						[1] -> [' private'].
						[2] -> [' protected'].
						[3] -> [' access undefined'] }.
		 self print: s].
	self print: ' nLits '; printNum: (objectMemory literalCountOfMethodHeader: methodHeaderOop);
		print: ' nArgs '; printNum: (self argumentCountOfMethodHeader: methodHeaderOop);
		print: ' nTemps '; printNum: (self temporaryCountOfMethodHeader: methodHeaderOop)