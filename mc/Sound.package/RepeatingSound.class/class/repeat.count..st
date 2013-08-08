instance creation
repeat: aSound count: anInteger
	"Return a RepeatingSound that will repeat the given sound for the given number of iterations."

	^ self new setSound: aSound iterations: anInteger
