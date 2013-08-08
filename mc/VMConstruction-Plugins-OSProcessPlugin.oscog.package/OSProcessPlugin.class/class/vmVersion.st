version dependent
vmVersion
	"After Squeak version 3.6, #vmVersion was moved to SmalltalkImage "

	^ ((Smalltalk classNamed: 'SmalltalkImage')
		ifNil: [^ Smalltalk vmVersion]) current vmVersion