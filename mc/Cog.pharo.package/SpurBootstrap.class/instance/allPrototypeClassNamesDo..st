method prototypes
allPrototypeClassNamesDo: aBlock
	"self basicNew allPrototypeClassNames"
	| pairs |
	pairs := Set new.
	self prototypeClassNameMetaSelectorMethodDo:
		[:className :isMeta :selector :method |
		pairs add: {className. isMeta}].
	pairs do: [:pair| aBlock value: pair first value: pair last]