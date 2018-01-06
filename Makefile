PYVM_Cpp_Files := $(wildcard src/*.cpp) $(filter-out $(wildcard test/*main.cpp), $(wildcard test/*.cpp))
PYVM_Include_Paths := 
PYVM_C_Flags := $(PYVM_Include_Paths)
PYVM_Cpp_Flags := $(PYVM_C_Flags) -std=c++11 
PYVM_Link_Flags := 
PYVM_Cpp_Objects := $(PYVM_Cpp_Files:.cpp=.o)

PY_Files := $(wildcard test/*.py)
PYC_Objects := $(PY_Files:.py=.pyc)

all: _start test_main $(PYC_Objects)

_start:
	@echo "======================================================="
	@echo "======================================================="
	@echo "    MAKE START"
	@echo "======================================================="
	@echo "======================================================="

src/%.o: src/%.cpp
	@echo "$(CXX)  <=  $<"
	@$(CXX) $(PYVM_Cpp_Flags) -c $< -o $@

test/%.o: test/%.cpp
	@echo "$(CXX)  <=  $<"
	@$(CXX) $(PYVM_Cpp_Flags) -c $< -o $@

test_main: test/main.o $(PYVM_Cpp_Objects)
	@echo "LINK =>  $@"
	@$(CXX) $^ -o $@ $(PYVM_Link_Flags)

test/%.pyc: test/%.py
	@echo "compileall python files to pyc"
	python -m compileall $<

clean:
	rm -f $(PYVM_Cpp_Objects)
	rm -f test/*.pyc
	rm test_main

