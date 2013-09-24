bootstrap image
findRequiredGlobals
	"Look for the necessary gobal bindings in the prototype methods in the old image.
	 This has to be done early by sending bindingOf: to Smalltalk.  Also find out
	 Metaclass, needed for identofying classes."
	| globals bindingOf |
	globals := Set new.
	self prototypeClassNameMetaSelectorMethodDo:
		[:c :m :s :method|
		globals addAll: (method literals select: [:l|
										l isVariableBinding
										and: [l key isSymbol
										and: [(Smalltalk bindingOf: l key) == l]]])].
	bindingOf := self findSymbol: #bindingOf:.
	self withExecutableInterpreter: oldInterpreter
		do:	[globals do:
				[:global|
				literalMap
					at: global
					put: (self interpreter: oldInterpreter
							object: (oldHeap splObj: 8) "Smalltalk"
							perform: bindingOf
							withArguments: {self findSymbol: global key})]].

	classMetaclass := oldHeap fetchClassOfNonImm: (oldHeap fetchClassOfNonImm: oldHeap classArray)