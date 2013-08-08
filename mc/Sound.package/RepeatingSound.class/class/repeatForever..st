instance creation
repeatForever: aSound
	"Return a RepeatingSound that will repeat the given sound forever."

	^ self new setSound: aSound iterations: #forever
