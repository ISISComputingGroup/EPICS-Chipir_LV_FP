TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

### NOTE: there should only be one build.mak for a given IOC family and this should be located in the ###-IOC-01 directory

#=============================
# Build the IOC application CHIPIRFP
# We actually use $(APPNAME) below so this file can be included by multiple IOCs

PROD_IOC = $(APPNAME)
# CHIPIRFP.dbd will be created and installed
DBD += $(APPNAME).dbd

# CHIPIRFP.dbd will be made up from these files:
$(APPNAME)_DBD += base.dbd
## ISIS standard dbd ##
$(APPNAME)_DBD += devSequencer.dbd
$(APPNAME)_DBD += icpconfig.dbd
$(APPNAME)_DBD += pvdump.dbd
$(APPNAME)_DBD += asSupport.dbd
$(APPNAME)_DBD += devIocStats.dbd
$(APPNAME)_DBD += caPutLog.dbd
## add other dbd here ##
#$(APPNAME)_DBD += xxx.dbd
$(APPNAME)_DBD += lvDCOM.dbd

# Add all the support libraries needed by this IOC
## ISIS standard libraries ##
$(APPNAME)_LIBS += seqDev seq pv
$(APPNAME)_LIBS += devIocStats 
$(APPNAME)_LIBS += pvdump easySQLite sqlite 
$(APPNAME)_LIBS += caPutLog
$(APPNAME)_LIBS += icpconfig pugixml
$(APPNAME)_LIBS += autosave
$(APPNAME)_LIBS += utilities pcre
## Add other libraries here ##
#$(APPNAME)_LIBS += xxx
$(APPNAME)_LIBS +=  lvDCOM asyn

# CHIPIRFP_registerRecordDeviceDriver.cpp derives from CHIPIRFP.dbd
$(APPNAME)_SRCS += $(APPNAME)_registerRecordDeviceDriver.cpp

$(APPNAME)_SYS_LIBS_WIN32 += msxml2

# Build the main IOC entry point on workstation OSs.
$(APPNAME)_SRCS_DEFAULT += $(APPNAME)Main.cpp
$(APPNAME)_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#$(APPNAME)_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
$(APPNAME)_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

