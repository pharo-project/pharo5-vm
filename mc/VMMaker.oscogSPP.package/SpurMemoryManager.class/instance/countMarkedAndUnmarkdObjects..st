debug support
countMarkedAndUnmarkdObjects: printFlags
	"print the count of marked and unmarked objects.
	 In addition if 1 is set in printFlags, short-print marked objects,
	 and/or if 2 is set, short-print unmarked obejcts."
	<api>
	| nm nu |
	nm := nu := 0.
	self allObjectsDo:
		[:o|
		(self isMarked: o)
			ifTrue:
				[nm := nm + 1.
				 (printFlags anyMask: 1) ifTrue:
					[coInterpreter shortPrintOop: o]]
			ifFalse:
				[nu := nu + 1.
				 (printFlags anyMask: 2) ifTrue:
					[coInterpreter shortPrintOop: o]]].
	self print: 'n marked: '; printNum: nm; cr.
	self print: 'n unmarked: '; printNum: nu; cr