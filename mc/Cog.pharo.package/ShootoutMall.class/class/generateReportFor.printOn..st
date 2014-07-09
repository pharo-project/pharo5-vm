printing
generateReportFor: creatures printOn: stream
   | sum |
   sum := creatures inject: 0 into: [:accum :each | accum + each creaturesMet].
   creatures do:
         [:aCreature |
         aCreature creaturesMet printOn: stream.
         stream
            space;
            nextPutAll: (self units at: aCreature selfMet + 1);
            nl].
   stream space.
   sum printString
      do: [:el | stream nextPutAll: (self units at: el digitValue + 1)]
      separatedBy: [stream space].
   ^stream