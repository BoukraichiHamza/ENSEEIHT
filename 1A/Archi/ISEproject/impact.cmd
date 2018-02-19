setMode -pff
setSubmode -pffserial
addPromDevice -p 1 -name xcf04s
addDesign -version 0 -name 0
addDeviceChain -index 0
addDevice -p 1 -file craps0.bit
generate -format mcs -fillvalue FF -output craps0
quit
