method prototypes
prototypeClassNameMetaSelectorMethodDo: quaternaryBlock
	"Evaluate aBlock with class name, class is meta, method and selector.
	 For now find methods in class-side category #'method prototypes'.
	 Scheme could be extended to have different protocols for different
	 Squeak/Pharo versions."
	self allPrototypeMethods do:
		[:protoSelector| | method className isMeta |
		method := SpurBootstrap class >> protoSelector.
		className := self classNameForPrototypeMethod: method.
		(isMeta := className endsWith: 'class') ifTrue:
			[className := (className allButLast: 5) asSymbol].
		quaternaryBlock
			value: className
			value: isMeta
			value: (self selectorForPrototypeMethod: method)
			value: method]