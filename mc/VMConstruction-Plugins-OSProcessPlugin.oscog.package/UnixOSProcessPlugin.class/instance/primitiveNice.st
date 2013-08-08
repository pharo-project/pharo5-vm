primitives - OS process access
primitiveNice
	"Change the scheduling priority of this process by the given nice increment.
	A positive increment decreases the priority. Only the superuser can specify
	a negative value (to increase the priority). See man(2) nice.

	Different versions of Unix are inconsistent in their return values. The only
	reliable test for success is to clear errno prior to the call, and test its value
	if the result of nice() is -1."

	| niceIncrement errno result |
	<export: true>
	<var: 'errno' type: 'extern int'>
	<var: 'niceIncrement' type: 'int'>
	niceIncrement := interpreterProxy stackIntegerValue: 0.
	errno := 0.
	result := self nice: niceIncrement.
	(result == -1) ifTrue:
		["sys call may have failed, test errno to be sure"
		(errno == 0) ifFalse:
			[^ interpreterProxy primitiveFail]].
	interpreterProxy pop: 2; pushInteger: result.
