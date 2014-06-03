stack pages
restoreStackLimit
	"restore the stackLimit if it has been smashed."
	<inline: true>
	stackPage stackLimit: stackPage realStackLimit.
	stackLimit := stackPage stackLimit