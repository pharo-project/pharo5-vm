reporting
generateFinalReport
	| count numMac ws |
	count := causes inject: 0 into: [:sum :collection| sum + collection size].
	rs reset.
	rs print: count; nextPutAll: ' VM Crashes. ? OpenGL. ? Audio plugin. ? Video plugin. ? Python plugin.  ? core VM. ? unknown.'; cr.
	numMac := (causes keys select: [:k| k beginsWith: 'Mac:']) size.
	rs nextPutAll: 'win: '; print: count- numMac; cr.
	rs nextPutAll: 'mac: '; print: numMac; cr; cr.
	self reportCrashRates: count.
	causes keys asSortedCollection do:
		[:k|
		(causes at: k) do:
			[:report| rs nextPutAll: report].
		rs nextPutAll: k; cr; cr].
	(ws := Workspace new contents: rs contents)
		acceptAction: [:s| (UIManager default confirm: 'Sure you want to send?') ifTrue:
							[self mailReport: s.
							 ws acceptAction:
								[(UIManager default confirm: 'You''ve already sent this. Sure you want to send again?') ifTrue:
										[self mailReport: s]]]];
		openLabel: 'Customer VM Crashes ', startDate date printString, ' to ', endDate date printString;
		shouldStyle: false