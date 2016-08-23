simulation
ioSignalOSSemaphore: aSemaphorePtr
	<var: #anOSSemaphore type: #'sqOSSemaphore *'>
	<returnTypeC: #void>
	<doNotGenerate>
	"See platforms/Cross/vm/sq.h for the real definition."
	aSemaphorePtr value signal