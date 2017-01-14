initialisation
activeVMMakerClassFor: platformName
	"Return the concrete VMMaker subclass for the platform on which we are currently running."

	VMMaker allSubclasses do: [:class |
		(class isActiveVMMakerClassFor: platformName) ifTrue: [^ class]].

	"no responding subclass; use VMMaker"
	^ VMMaker
