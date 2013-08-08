private
indexForDeltaFrom: thisSample to: nextSample
	"Answer the best index to use for the difference between the given samples."
	"Details: Scan stepSizeTable for the first entry >= the absolute value of the difference between sample values. Since indexes are zero-based, the index used during decoding will be the one in the following stepSizeTable entry. Since the index field of a Flash frame header is only six bits, the maximum index value is 63."
	"Note: Since there does not appear to be any documentation of how Flash actually computes the indices used in its frame headers, this algorithm was guessed by reverse-engineering the Flash ADPCM decoder."
	
	<inline: true>

	| diff bestIndex |
	
	diff := nextSample - thisSample.
	diff < 0 ifTrue: [diff := 0 - diff].
	bestIndex := 63.
	1 to: 62 do: [:j |
		bestIndex = 63 ifTrue: [
			(stepSizeTable at: j) >= diff ifTrue: [bestIndex := j]]].
	^ bestIndex
