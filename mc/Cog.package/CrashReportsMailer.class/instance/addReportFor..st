reporting
addReportFor: lines
	rs	resetContents;
		tab;
		nextPutAll: ((lines detect: [:l| l beginsWith: 'Subject:']) ifNotNil:
							[:l| l allButFirst: (l indexOfSubCollection: ' Teleplace Bug')]);
		crtab: 2;
		nextPutAll: (lines detect: [:l| l beginsWith: 'Date:']);
		cr.
	((lines anySatisfy: [:l| (l beginsWith: 'OS Version') and: [l includesSubString: 'Mac OS X']])
		ifTrue: [self reportForMacOS: lines]
		ifFalse: [(lines anySatisfy: [:l| l beginsWith: 'Module:'])
					ifTrue: [self reportForOldWin32: lines]
					ifFalse: [self reportForNewWin32: lines]]) ifNotNil:
			[:cause|
			(causes at: cause ifAbsentPut: [OrderedCollection new])
				addLast: rs contents]