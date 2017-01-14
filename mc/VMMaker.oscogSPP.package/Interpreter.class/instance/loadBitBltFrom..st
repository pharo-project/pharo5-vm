bitblt support
loadBitBltFrom: bb
	"This entry point needs to be implemented for the interpreter proxy.
	Since BitBlt is now a plugin we need to look up BitBltPlugin:=loadBitBltFrom
	and call it. This entire mechanism should eventually go away and be
	replaced with a dynamic lookup from BitBltPlugin itself but for backward
	compatibility this stub is provided"
	| fn |
	<var: #fn type: 'void *'>
	fn := self ioLoadFunction: 'loadBitBltFrom' From: 'BitBltPlugin'.
	fn = 0 ifTrue: [^self primitiveFail].
	^self cCode: '((sqInt (*)(sqInt))fn)(bb)'