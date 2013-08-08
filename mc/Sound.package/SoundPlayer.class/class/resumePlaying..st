playing
resumePlaying: aSound
	"Start playing the given sound without resetting it; it will resume playing from where it last stopped."
	"Implementation detail: On virtual machines that don't support the quickstart primitive, you may need to edit this method to pass false to resumePlaying:quickStart:."

	self resumePlaying: aSound quickStart: true.
