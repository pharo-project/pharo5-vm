class initialization
initializeWithOptions: optionsDictionary

	self syncCodeWithSistaCogit ifTrue: "The subclass's #initializeWithOptions: method changed; resend."
		[^self initializeWithOptions: optionsDictionary].

	"Things are up-to-date; continue"
	^super initializeWithOptions: optionsDictionary