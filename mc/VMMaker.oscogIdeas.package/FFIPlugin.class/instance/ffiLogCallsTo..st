initialize
ffiLogCallsTo: fileName
	"This is a special entry point exposed such that client code can 
	enable and disable logging of FFI calls."
	| ok |
	<export: true>
	<var: #fileName type: 'char*'>
	fileName == nil ifTrue:[ "disable logging"
		ok := self ffiLogFileName: nil OfLength: 0.
		ok ifFalse:[^false].
		ffiLogEnabled := false.
	] ifFalse:[ "enable logging"
		ok := self ffiLogFileName: fileName OfLength: (self strlen: fileName).
		ok ifFalse:[^false].
		ffiLogEnabled := true.
	].
	^true