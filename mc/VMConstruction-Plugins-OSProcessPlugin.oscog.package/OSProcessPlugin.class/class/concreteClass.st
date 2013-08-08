translation
concreteClass

	"OSProcessPlugin concreteClass"

	| numericOsVersion |
	(self platformName = 'Win32') ifTrue: [^ Win32OSProcessPlugin].
	(self platformName = 'unix') ifTrue: [^ UnixOSProcessPlugin].
	numericOsVersion := self osVersion asInteger ifNil: [0].
	((self platformName = 'Mac OS') and: [numericOsVersion >= 1000])
		ifTrue: [^ UnixOSProcessPlugin concreteClass].
	self inform: 'no concrete class available for ', self platformName.
	^ nil
