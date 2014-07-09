*Cog-Benchmarks-Shootout-platform
print: number digits: decimalPlaces
   | precision rounded |
   decimalPlaces <= 0 ifTrue: [^ number rounded printString].
   precision := Utilities floatPrecisionForDecimalPlaces: decimalPlaces.
   rounded := number roundTo: precision.
   self nextPutAll: 
      ((rounded asScaledDecimal: decimalPlaces) printString copyUpTo: $s)