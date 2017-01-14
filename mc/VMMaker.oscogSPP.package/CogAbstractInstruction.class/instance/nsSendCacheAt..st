inline cacheing
nsSendCacheAt: callSiteReturnAddress
	"Answer the NSSendCache for the return address of a Newspeak
	 self, super, outer, or implicit receiver send."
	<option: #NewspeakVM>
	^self subclassResponsibility