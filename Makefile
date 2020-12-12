# Use one of these targets to build:
# debug, beta, release, clean

# Variables and targets needed for build
include utilities/common.make

# ACS files
acsDir := pk3/acs
sourceDir := pk3/scripts
acsFiles := \
	$(acsDir)/hubret.o
    
$(acsDir):
	@$(MKDIR) $(MKDIRFLAGS) $@
$(acsDir)/hubret.o: $(sourceDir)/HubReturn.acs | $(acsDir)
	$(ACC) $< $@

# PK3 files
jmcContents = $(shell $(FIND) pk3 $(FINDFLAGS) -newer $(targetDir)/jmc-$(targetSuffix).pk3 2>/dev/null)
    
pk3Files := \
	$(targetDir)/jmc-$(targetSuffix).pk3

$(targetDir):
	@$(MKDIR) $(MKDIRFLAGS) $@
$(targetDir)/jmc-$(targetSuffix).pk3: pk3 $(jmcContents) $(acsFiles) | $(targetDir)
	@$(DEL) $(DELFLAGS) $@
	$(SEVENZA) $(SEVENZAFLAGS) $@ ./$</*

# Build target
build: $(pk3Files)

# Clean target
clean: cleanCommon
	@echo Clean operation complete.

