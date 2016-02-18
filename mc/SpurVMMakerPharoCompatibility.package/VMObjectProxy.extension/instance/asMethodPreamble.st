*SpurVMMakerPharoCompatibility
asMethodPreamble
	"Just happens when proxy is a symbol. 
	 So far, this is used in the override for #codeForNoSource"
	| selector |
	selector := self coInterpreter shortPrint: self oop. 
	selector first = $# ifTrue: [ selector := selector allButFirst ].
	^ selector asSymbol asMethodPreamble