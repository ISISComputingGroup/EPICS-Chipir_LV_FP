#!../../bin/windows-x64/CHIPIRFP

## You may have to change CHIPIRFP to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

## Register all support components
dbLoadDatabase "dbd/CHIPIRFP.dbd"
CHIPIRFP_registerRecordDeviceDriver pdbbase

##ISIS## Run IOC initialisation 
< $(IOCSTARTUP)/init.cmd

## Load record instances

##ISIS## Load common DB records 
< $(IOCSTARTUP)/dbload.cmd

## Load our record instances
#dbLoadRecords("db/xxx.db","user=kvlb23Host")
#epicsEnvSet "IOCNAME" "$(P=$(MYPVPREFIX))CHIPIRFP"
#lvDCOMConfigure("frontpanel", "frontpanel", "$(TOP)/CHIPIRFPApp/protocol/CHIPIRFP.xml", "ndxchipir", 6, "", "spudulike", "reliablebeam")
lvDCOMConfigure("frontpanel", "frontpanel", "$(TOP)/CHIPIRFPApp/protocol/CHIPIRFP.xml", "ndw1032", 6, "", "", "")
dbLoadRecords("$(TOP)/db/CHIPIRFP.db","P=$(MYPVPREFIX)CHIPIRFP:")

##ISIS## Stuff that needs to be done after all records are loaded but before iocInit is called 
< $(IOCSTARTUP)/preiocinit.cmd

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs
#seq sncxxx,"user=kvlb23Host"

##ISIS## Stuff that needs to be done after iocInit is called e.g. sequence programs 
< $(IOCSTARTUP)/postiocinit.cmd
