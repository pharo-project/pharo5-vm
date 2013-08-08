printing
generateReportOfColoursOn: readOut
   | colours |
   colours := Array
            with: Blue
            with: Red
            with: Yellow.
   colours do:
         [:aColour |
         colours do:
               [:anotherColour |
               aColour printOn: readOut.
               readOut nextPutAll: ' + '.
               anotherColour printOn: readOut.
               readOut nextPutAll: ' -> '.
               (aColour complementaryColourFor: anotherColour) printOn: readOut.
               readOut nl]].
   ^readOut