transformations
transformToStructClassMethodFor: aCCodeGenerator
	"Transform this method so that it can be used on an instance of a struct class (VMStructType subclass).
	 Convert inst var refs into field dereferences of self.  Add selfSelector as the first argument with the
	 right struct type. As a complete hack to avoid breaking the inlinert don't use 'self' as the name for self
	 as this causes serious type redefinitions ``somewhere'' in the inliner."
	| replacements selfNode typeForSelf |
	self isStructAccessor ifTrue:
		[^self returnType: (definingClass returnTypeForAccessor: selector)].
	replacements := IdentityDictionary new.
	selfNode := TVariableNode new setName: 'self_in_', (aCCodeGenerator cFunctionNameFor: selector).
	args do:
		[:var|
		(definingClass isAccessor: var) ifTrue:
			[self error: 'In ', definingClass name, '>>', selector, ' ', var, ' arg shadows struct field and will break during translation!']].
	parseTree nodesDo:
		[:node|
		node isVariable ifTrue:
			[node name = 'self' ifTrue:
				[replacements at: node put: selfNode copy].
			 (definingClass isAccessor: node name) ifTrue:
				[replacements
					at: node
					put: (TSendNode new
							setSelector: node name asSymbol
							receiver: selfNode
							arguments: #())]]].
	replacements notEmpty ifTrue:
		[parseTree := parseTree replaceNodesIn: replacements].
	typeForSelf := self typeForSelf.
	self assert: (typeForSelf notNil and: [typeForSelf ~~ #implicit]).
	self declarationAt: (args addFirst: selfNode name)
		put: (declarations removeKey: 'self'), '_in_', (aCCodeGenerator cFunctionNameFor: selector)