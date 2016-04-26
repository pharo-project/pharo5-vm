compile abstract instructions
preenMethodLabel
	"The methodLabel serves as the reference to the start of the current code object
	 being produced (CMMethod, CMClosedPIC etc), but it also carries type flags for
	 the frame method field, set via the labelOffset.  So we must clean the flags on each
	 compilation to avoid stale lags being left behind from previous compilations."
	<inline: true>
	methodLabel setLabelOffset: 0