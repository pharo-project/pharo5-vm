primitive support
addIdleUsecs: idleUsecs
	"The various poll/select calls in the VM should attempt to tally the ammount
	 of time spent at idle here, so as to render the uptime value meaningful."
	<export: true>
	statIdleUsecs := statIdleUsecs + idleUsecs