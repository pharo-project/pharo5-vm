file primitives
getThisSession
	"Exported entry point for the VM. Only used by AsynchFilePlugin and needs to be reowrked now we have a VM global session Id capability"
	<export: true> 
	^self cCode: 'sqFileThisSession()'.