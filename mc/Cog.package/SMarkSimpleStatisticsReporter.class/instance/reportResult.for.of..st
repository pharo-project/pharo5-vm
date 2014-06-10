reporting
reportResult: aResultsArray for: aCriterion of: benchmark
	| convidenceVariance significantDigits |

	stream << benchmark <<  ' ' <<  aCriterion <<  ': iterations='.
	aResultsArray size printOn: stream .
	stream << ' runtime: '.
	
	aResultsArray size < 2 ifTrue: [
		aResultsArray average printOn: stream.
		stream << 'ms'.
		^ self.
	].
	
	convidenceVariance := self confidenceVariance: aResultsArray.  
	
	"only print significant "
	significantDigits := self significantDigits: convidenceVariance.

	aResultsArray average printOn: stream showingDecimalPlaces: significantDigits.
	stream << 'ms +/-'.
	convidenceVariance printOn: stream showingDecimalPlaces: significantDigits.