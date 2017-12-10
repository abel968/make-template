#define function
define get_dynamic_library
$(foreach n, $(filter lib%.so,$(shell ls $(1))), $(patsubst lib%.so,-L$(1) -l%,$(n)))
endef

#targe name
target := make-template

#here add include path
CXXFLAGS += -I include/
CXXFLAGS += -I /usr/local/opencv-3.3.0/include/

#here add dynamic libraries
LIBS := 
OpencvLibDir := /usr/local/opencv-3.3.0/lib/
LIBS += $(call get_dynamic_library,$(OpencvLibDir))

#here file.d and file.o
vpath %.cpp src/
vpath %.d $(dependence_dir)
vpath %.h include/
vpath %.hpp include/
dependence_dir = .dependence/
source = $(shell ls src)
dependence := $(filter %.d,$(source:%.cpp=%.d))

obj_dir = .objs/
obj = $(source:%.cpp=%.o)

#here start compile
#$(target): $(dependence_dir) $(dependence) main.o
$(target): $(dependence_dir) $(addprefix $(dependence_dir),$(dependence)) $(obj_dir) $(addprefix $(obj_dir), $(obj))
	g++ -o $@ $(addprefix $(obj_dir), $(obj)) $(LIBS) 
$(dependence_dir)%.d: %.cpp
	echo "$(obj_dir)\c" > $@
	$(CXX) -MM $< $(CXXFLAGS) >> $@
	echo "\t$(CXX) -o $(obj_dir)$(patsubst %.cpp,%.o,$(notdir $<)) -c $< $(CXXFLAGS)" >> $@
-include $(dependence_dir)*
$(dependence_dir):
	mkdir -p ./$@
$(obj_dir):
	mkdir -p ./$@
.PHONY:all clean tar
all:
	@echo all
clean:
	@echo "start clean..."
	-$(RM) $(target)
	-$(RM) -r $(dependence_dir)
	-$(RM) -r $(obj_dir)
	@echo "clean completely"
tar:
	tar -zcvf ../$(target).tar.gz .
