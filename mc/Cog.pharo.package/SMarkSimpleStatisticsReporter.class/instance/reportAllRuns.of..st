reporting
reportAllRuns: aListOfResults of: benchmark
	| criteria |

	criteria := aListOfResults first criteria.
	
	criteria keysDo: [:criterion |
		| times |
		times := self resultsFor: criterion from: aListOfResults.
		self reportResult: times for: criterion of: benchmark.
		stream cr.
	].