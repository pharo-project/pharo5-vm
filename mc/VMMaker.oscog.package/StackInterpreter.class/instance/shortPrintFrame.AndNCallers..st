debug printing
shortPrintFrame: theFP AndNCallers: n
	<api>
	<inline: false>
	<var: #theFP type: #'char *'>
	(n ~= 0 and: [stackPages couldBeFramePointer: theFP]) ifTrue:
		[self shortPrintFrame: theFP.
		 self shortPrintFrame: (self frameCallerFP: theFP) AndNCallers: n - 1]