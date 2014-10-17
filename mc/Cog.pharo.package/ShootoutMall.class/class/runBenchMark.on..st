public
runBenchMark: number on: anOutputStream
   "self runBenchMark: 60000 on: Transcript."

   | firstTestColours secondTestColours blue red yellow creatures |
   blue := ShootoutChameneosColour blue.
   red := ShootoutChameneosColour red.
   yellow := ShootoutChameneosColour yellow.
   firstTestColours := Array
            with: blue
            with: red
            with: yellow.
   secondTestColours := (OrderedCollection new)
            add: blue;
            add: red;
            add: yellow;
            add: red;
            add: yellow;
            add: blue;
            add: red;
            add: yellow;
            add: red;
            add: blue;
            yourself.
   (ShootoutChameneosColour generateReportOfColoursOn: anOutputStream) nl.
   (self generateReportForColours: firstTestColours printOn: anOutputStream)
      nl.
   creatures := ShootoutMall openMallWith: firstTestColours forNumberOfMeets: number.
   (self generateReportFor: creatures printOn: anOutputStream)
      nl;
      nl.
   (self generateReportForColours: secondTestColours printOn: anOutputStream)
      nl.
   creatures := ShootoutMall openMallWith: secondTestColours forNumberOfMeets: number.
   (self generateReportFor: creatures printOn: anOutputStream)
      nl;
      nl