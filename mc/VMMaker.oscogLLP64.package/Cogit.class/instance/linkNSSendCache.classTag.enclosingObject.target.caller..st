newspeak support
linkNSSendCache: nsSendCache classTag: classTag enclosingObject: enclosingObject target: targetMethod caller: callingMethod
	<api>
	<option: #NewspeakVM>
	<var: #nsSendCache type: #'NSSendCache *'>
	<var: #targetMethod type: #'CogMethod *'>
	<var: #callingMethod type: #'CogMethod *'>
	nsSendCache classTag: classTag.
	nsSendCache enclosingObject: enclosingObject.
	nsSendCache target: targetMethod asInteger + cmNoCheckEntryOffset.
	callingMethod cmRefersToYoung ifFalse:
		[(enclosingObject ~= 0 and: [objectMemory isYoung: enclosingObject]) ifTrue:
			[methodZone ensureInYoungReferrers: callingMethod]].
