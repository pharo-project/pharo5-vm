translation
version
	"Answer the receiver's version info as String."
	"Somewhat a hack, but calling class methods from inst methods doesn't result in usable C-code..."

	| inst |
	inst := self new.
	^ 'v', inst majorNO asString, '.', inst minorNO asString