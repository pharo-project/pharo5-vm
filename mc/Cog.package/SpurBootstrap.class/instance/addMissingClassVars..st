bootstrap image
addMissingClassVars: classVars
	"Add any missing class vars given classVars, a Dictionary from nonMetaClass to binding.
	 Initialize any classes that get inst vars added."
	| addClassVarNameSym bindingOfSym |
	classVars isEmpty ifTrue:
		[^self].
	addClassVarNameSym := self findSymbol: #addClassVarName:.
	addClassVarNameSym ifNil: 
		[addClassVarNameSym := self findSymbol: #addClassVarNamed:].
	bindingOfSym := self findSymbol: #bindingOf:.
	classVars keysAndValuesDo:
		[:binding :class| 
		Transcript cr;  nextPutAll: 'ADDING CLASS VAR '; store: binding key; nextPutAll: ' TO '; print: class; flush.
		self interpreter: oldInterpreter
			object: (self oldClassOopFor: class)
			perform: addClassVarNameSym
			withArguments: {oldHeap stringForCString: binding key}.
		literalMap
			at: binding
			put: (self interpreter: oldInterpreter
					object: (self oldClassOopFor: class)
					perform: bindingOfSym
					withArguments: {self findSymbol: binding key})].
	toBeInitialized := classVars asSet