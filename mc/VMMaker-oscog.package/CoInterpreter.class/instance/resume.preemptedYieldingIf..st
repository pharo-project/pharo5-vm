process primitive support
resume: aProcess preemptedYieldingIf: yieldImplicitly
	"Replaced by resume:preemptedYieldingIf:from:"
	"Make aProcess runnable and if its priority is higher than  that of the
	 current process, preempt the current process.   Answer if the current
	 process was preempted.  If the current process was preempted then if
	 yieldImplicitly add the current process to the back of its run queue,
	 causing an implicit yiled to other processes on the run queue,  otherwise
	 add the current process to the front of its run queue, hence not yielding.
	 Blue book behaviour is to yield implicitly but is arguably incorrect."
	<doNotGenerate>
	self shouldNotImplement