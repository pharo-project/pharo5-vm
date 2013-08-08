translation
touch
	"Reset the timeStamp"
	"Smalltalk allClasses select:
		[:c| (c category includesSubString: 'VMMaker-JIT') ifTrue: [c touch]]"
	"InterpreterPlugin withAllSubclassesDo:[:pl| pl touch]"
	timeStamp := Time totalSeconds