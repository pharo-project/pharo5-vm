type inference
typeOrNilFrom: aCodeGenerator in: aTMethod
	"For integers, answer int unless the value does not fit into a 32bits signed int.
	In that case, answer the shortest architecture independant integer type that could hold the constant.
	This method must be consistent with CCodeGenerator>>cLiteralFor:"
	| hb |
	value isInteger
		ifTrue:
			[value positive
				ifTrue:
					[hb := value highBit.
					hb < 32 ifTrue: [^#int].
					hb = 32 ifTrue: [^#'unsigned int'].
					hb = 64 ifTrue: [^#'unsigned long long'].
					^#'long long']
				ifFalse:
					[hb := value bitInvert highBit.
					hb < 32 ifTrue: [^#int].
					^#'long long']].
	value isFloat ifTrue: [^#double].
	(#(nil true false) includes: value) ifTrue: [^#int].
	(value isString and: [value isSymbol not]) ifTrue: [^#'char *'].
	^nil