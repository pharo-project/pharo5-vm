printing
generateReportForColours: colours printOn: stream
   stream space.
   colours do: [:colour | colour printOn: stream] separatedBy: [stream space].
   ^stream