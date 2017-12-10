#define function
define get_dynamic_library
$(foreach n, $(filter lib%.so,$(shell ls $(1))), $(patsubst lib%.so,-L$(1) -l%,$(n)))
endef

#targe name
target := make-template

#here add include path
CFLAGS += -I include/
CFLAGS += -I /usr/local/opencv-3.3.0/include/
CXXFLAGS += -I include/
CXXFLAGS += -I /usr/local/opencv-3.3.0/include/

#here add dynamic libraries
LIBS := 
OpencvLibDir := /usr/local/opencv-3.3.0/lib/
LIBS += $(call get_dynamic_library,$(OpencvLibDir))

#here file.d and file.o
vpath %.cpp src/
vpath %.c src/
vpath %.d $(dependence_dir)
vpath %.h include/
vpath %.hpp include/
dependence_dir = .dependence/
source = $(shell ls src)
dependence := $(filter %.dxx,$(source:%.cpp=%.dxx))
dependence += $(filter %.d, $(source:%.c=%.d))

obj_dir = .objs/
obj := $(source:%.cpp=%.o)
obj += $(source:%.c=%.o)
obj := $(filter %.o, $(obj))

#here start compile
#$(target): $(dependence_dir) $(dependence) main.o
$(target): $(dependence_dir) $(addprefix $(dependence_dir),$(dependence)) $(obj_dir) $(addprefix $(obj_dir), $(obj))
	g++ -o $@ $(addprefix $(obj_dir), $(obj)) $(LIBS) 
$(dependence_dir)%.dxx: %.cpp
	echo "$(obj_dir)\c" > $@
	$(CXX) -MM $< $(CXXFLAGS) >> $@
	echo "\t$(CXX) -o $(obj_dir)$(patsubst %.cpp,%.o,$(notdir $<)) -c $< $(CXXFLAGS)" >> $@
$(dependence_dir)%.d: %.c
	echo "$(obj_dir)\c" > $@
	$(CC) -MM $< $(CFLAGS) >> $@
	echo "\t$(CC) -o $(obj_dir)$(patsubst %.c,%.o,$(notdir $<)) -c $< $(CFLAGS)" >> $@
-include $(dependence_dir)*
$(dependence_dir):
	mkdir -p ./$@
$(obj_dir):
	mkdir -p ./$@
.PHONY:all clean tar
all:
	@echo $(obj) 
clean:
	@echo "start clean..."
	-$(RM) $(target)
	-$(RM) -r $(dependence_dir)
	-$(RM) -r $(obj_dir)
	@echo "clean completely"
tar:
	tar -zcvf ../$(target).tar.gz .
