utilities
prepareMethods
	| globals |
	globals := Set new: 200.
	globals addAll: variables.
	methods do:
		[:m |
		m locals, m args do:
			[:var |
			(globals includes: var) ifTrue:
				[self error: 'Local variable name may mask global when inlining: ' , var].
			((methods at: var ifAbsent: [nil]) ifNil: [false] ifNotNil: [:m1| m1 isStructAccessor not]) ifTrue:
				[logger
					ensureCr;
					nextPutAll: 'Local variable name ', var, ' in ';
					nextPutAll: m selector;
					nextPutAll: ' may mask method when inlining: ' , var]].
		m bindClassVariablesIn: constants.
		m prepareMethodIn: self]