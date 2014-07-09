as yet unclassified
createFor: aSelector for: numIterations with: aRunner and: aSuite
	| o |
	o := self new.
	o runner: aRunner.
	o suite: aSuite.
	o innerIterations: numIterations.
	o benchmarkSelector: aSelector.
	^ ([ o run ] newProcess)