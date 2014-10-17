private
showProgressFor: aClass
	"Announce that we're processing aClass"
	progress == nil ifTrue:[^self].
	aClass isObsolete ifTrue:[^self].
	currentClassIndex := currentClassIndex + 1.
	(aClass hasMethods) ifTrue:
		[progress label: ('Recompiling ', aClass name, ' (', currentClassIndex printString, '/', maxClassIndex printString, ')')]