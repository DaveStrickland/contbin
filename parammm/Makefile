# sensible compiler flags
LIBS = -lparamm
INCS = 
CXX = g++
CXXFLAGS = -std=c++11 -O2 -g -Wall $(INCS)
LDR = g++
LDRFLAGS = -L. $(LIBS)

libobjs = switch_option.o pswitch.o param.o autohelp.o autoversion.o

cc.o:
	$(CXX) $(CXXFLAGS) $<

all:	libparammm.a

clean:
	rm -vf *.o *.a

switch_option.o : switch_option.hh
pswitch.o : pswitch.hh switch_option.hh
param.o : param.hh pswitch.hh switch_option.hh
autohelp.o : autohelp.hh switch_option.hh pswitch.hh
autoversion.o : autoversion.hh switch_option.hh pswitch.hh

libparammm.a: $(libobjs)
	ar ruv libparammm.a $?
	ranlib libparammm.a

test : test.o libparammm.a
	$(LDR) -o test test.o $(LDRFLAGS)
