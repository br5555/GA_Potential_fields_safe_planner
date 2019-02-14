function result_Map = calculate_cost(Map,  grid_rows, grid_col, epsilon, lambda)
% Calibrates the HiTechnic EOPD sensor (measures/sets calibration matrix)
%
% Syntax
%   CalibrateEOPD(port, 'NEAR', nearDist)
%
%   CalibrateEOPD(port, 'FAR', farDist)
%
%   calibMatrix = CalibrateEOPD(port, 'READMATRIX')
%
%   CalibrateEOPD(port, 'SETMATRIX', calibMatrix)
%
% Description
%   To help you make sense of the HiTechnic EOPD sensor values, this
%   function can calibrate the sensor. The method is based on this article:
%   http://www.hitechnic.com/blog/eopd-sensor/eopd-how-to-measure-distance/#more-178
%
%   Before your start calibration, open the sensor using OpenEOPD and a
%   mode of your choice. Please note: The calibration will be valid for
%   this mode only. So if you choose long range mode during calibration,
%   you must use this mode all the time when working with this specific
%   calibration setting.
%
%   The calibration process is straight forward. You place the sensor at a
%   known distance in front of a surface. First you need to chose a short
%   distance, e.g. around 3cm (not too close). Then you call this function with 
%   calibrationMode = 'NEAR', followed by nearDist set to the actual
%   distance. This can be centimeters, millimeters, or LEGO studs. The unit
%   doesn't matter as long as you keep it consistend. The value later
%   returned by GetEOPD will be in this exact units.
%
%   As second step, you have to place the sensor at another known distance,
%   preferrably at the end of the range. Let's just say we use 9cm this
%   time. Now call this functions with calibrationMode = 'FAR', followed
%   by a 9. That's it. The sensor is now calibrated.
%
%   Before you continue to use the sensor, you should retrieve the 
%   calibration matrix and store it for later use. This matrix is
%   essentialy just a combination of the two distances you used for
%   calibration, and the according EOPD raw sensor readings. Out of these
%   two data pairs, the distance mapping is calculated, which is used inside
%   GetEOPD. To retrieve the matrix, call calibMatrix =
%   CalibrateEOPD(port, 'READMATRIX').
%
%   If later on you want to leave out the calibration of a specific EOPD
%   sensor for certain environmental conditions, you can simply re-use the
%   calibration matrix. Call CalibrateEOPD(port, 'SETMATRIX',
%   calibMatrix). The format of the 2x2 calibMatrix is:
%   [nearDist nearEOPD; farDist farEOPD].
% 
%   To summarize:
% 
% # Use the 'NEAR' mode with a short distance to the surface.
% # Use the 'FAR' mode with a long distance to the surface (all
%   relatively. The order can be swapped).
% # Retrieve and store the calibration matrix using the 'READMATRIX'
% mode.
% # Later on, if you want to skip steps 1 - 3, just directly load the matrix
% from step 3 using the 'SETMATRIX' mode.
% 
%   
% Limitations
%   Calibration is stored inside the NXT handle, for a specific port. This
%   means after closing the NXT handle, or when connecting the sensor to
%   another port, calibration is lost. That is why you should either always
%   run the calibration at the begin of your program, or restore the
%   previous state with the 'SETMATRIX' calibration mode.
%
%   Unlike most other functions, this one cannot be called with an NXT
%   handle as last argument. Please use COM_SetDefaultNXT before.
%
%
% Examples
%   port = SENSOR_2;
%   OpenEOPD(port, 'SHORT');
%
%   % place sensor to 3cm distance, you can also try 2cm or similar
%   CalibrateEOPD(port, 'NEAR', 3);
%   pause;
%
%   % place sensor to 9cm distance, you can also try 10cm or similar
%   CalibrateEOPD(port, 'FAR', 9);
%
%   % retrieve & display calibration matrix
%   calibMatrix = CalibrateEOPD(port, 'READMATRIX');
%   disp(calibMatrix);
%
%   % now the sensor can be used
%   [dist raw] = GetEOPD(port);
%
%   % clean up, as usual. LED stays on anyway
%   CloseSensor(port);
%
%   % Later on in another program, you can
%   % restore the calibration:
%   OpenEOPD(port, 'SHORT'); % use same mode as for calibration
%
%   % manually set calibMatrix or load from file
%
%   % now restore calibration
%   CalibrateEOPD(port, 'SETMATRIX', calibMatrix);
%
%   % sensor ready to be used now...
%
% See also: OpenEOPD, GetEOPD, CloseSensor, NXT_SetInputMode, NXT_GetInputValues
%
% Signature
%   Author: Linus Atorf (see AUTHORS)
%   Date: 20010/09/22
%   Copyright: 2007-2011, RWTH Aachen University
%
for i = 1: grid_rows
    for j = 1: grid_col
        Map(i,j).cost =  epsilon*Map(i,j).appealing + lambda* Map(i,j).repellent;
    end
end

result_Map = Map;
end