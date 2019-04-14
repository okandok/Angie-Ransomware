CLFL_BUILD_release = /DRELEASE
CLFL_BUILD_debug   = /Z7 /DDEBUG /DDEBUG_LEVEL=3 /DDEBUG_C_ASSERT

CLFL_INCLUDE = /I$(PROJECT_INCLUDE_PATH)/ /FI$(PROJECT_INCLUDE_PATH)/stdafx.h
CLFL_BASE    = /Wall $(CLFL_INCLUDE) $(CLFL_BUILD_$(PROJECT_BUILD)) /J /Gr /GS:off /Qms0 /Qsafeseh- /Qcf-protection:none /Qfreestanding /DRIVER /KERNEL  /LARGEADDRESSAWARE /DYNAMICBASE /NODEFAULTLIB
CLFL_CPU     = /arch:SSE2 /tune:generic /Qopt-prefetch /Qopt-prefetch:2
CLFL_OX      = /Qipo /Os /Ob2 /GF /GA /Zp16 /Qunroll8 /Qsfalign16 /Qfnalign8
CC           = @icl.exe /nologo

LDFL_BUILD_release = /RELEASE
LDFL_BUILD_debug   = /DEBUG

LDFL = /MACHINE:X86 /MANIFEST:NO /DYNAMICBASE /SUBSYSTEM:CONSOLE /GUARD:NO /SAFESEH:NO /OPT:REF /ENTRY:Entry $(LDFL_BUILD_$(PROJECT_BUILD)) KERNEL32.LIB WS2_32.LIB BCRYPT.LIB
LD   = @xilink.exe /NOLOGO /TIME /LIBPATH:"$(PROJECT_LIB_PATH)/"

# 1   path
# 2   module name
# 3   makefile rule
# 4   additional define
define CompileModule
	$(info # Compiling "$(2)")
	@make -s -j --no-print-directory -C $(1)$(2) -f Makefile $(3) CLFL_ADDON="$(4)" CC="$(CC)" CLFL_BASE="$(CLFL_BASE) /I$(PROJECT_INCLUDE_PATH)/$(2)" CLFL_CPU="$(CLFL_CPU)" CLFL_OX="$(CLFL_OX)"
endef

all: rtlp core crypto master link r

rtlp:
	$(CC) $(CLFL_BASE) $(CLFL_CPU) $(CLFL_OX) $(CLFL_ADDON) /c source/source/rtlp/*.c /Fo:$(PROJECT_OBJECT_PATH)/rtlp/

core:
	$(CC) $(CLFL_BASE) $(CLFL_CPU) $(CLFL_OX) $(CLFL_ADDON) /c source/source/core/*.c /Fo:$(PROJECT_OBJECT_PATH)/core/

crypto:
	$(CC) $(CLFL_BASE) $(CLFL_CPU) $(CLFL_OX) $(CLFL_ADDON) /c source/source/crypto/*.c /Fo:$(PROJECT_OBJECT_PATH)/crypto/

master:
	$(CC) $(CLFL_BASE) $(CLFL_CPU) $(CLFL_OX) $(CLFL_ADDON) /c source/source/master/*.c /Fo:$(PROJECT_OBJECT_PATH)/master/

link:
	$(LD) /NOLOGO /TIME $(LDFL) /MAP:$(PROJECT_BIN_PATH)/$(PROJECT_BUILD)/Master.map /PDB:$(PROJECT_BIN_PATH)/$(PROJECT_BUILD)/Master.pdb /OUT:$(PROJECT_BIN_PATH)/$(PROJECT_BUILD)/Master.exe \
	$(PROJECT_OBJECT_PATH)/rtlp/*.obj \
	$(PROJECT_OBJECT_PATH)/core/*.obj \
	$(PROJECT_OBJECT_PATH)/crypto/*.obj \
	$(PROJECT_OBJECT_PATH)/master/*.obj

r:
	"$(PROJECT_BIN_PATH)/$(PROJECT_BUILD)/Master.exe"