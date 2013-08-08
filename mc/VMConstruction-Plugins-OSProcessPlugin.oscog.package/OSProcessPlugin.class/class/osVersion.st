version dependent
osVersion
	"After Squeak version 3.6, #osVersion was moved to SmalltalkImage "

	^ ((Smalltalk classNamed: 'SmalltalkImage')
		ifNil: [^ Smalltalk osVersion]) current osVersion