accessing
estimateOfAbstractOpcodesPerBytecodes
	"Due to the counter logic, the estimation is higher"
	<inline: true>
	self flag: 'we could fix that when #== generates less instructions'.
	^ 14