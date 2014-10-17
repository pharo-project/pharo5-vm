utilities
fixupMethodClassBindings
	"Work-around the Monticello bug that results in not sharing the binding in Smalltalk as a method's methodClassAssociation."
	"self fixupMethodClassBindings"
	self systemNavigation allSelect:
		[:m|
		(m methodClass isMeta not
		 and: [m methodClassAssociation key isNil]) ifTrue:
			[m methodClassAssociation: m methodClass binding].
		false]