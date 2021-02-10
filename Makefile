# Makefile for contbin, Jeremy Sanders
######################################
#

# where to install (not very well tested)
bindir=/usr/local/bin

# sensible compiler flags
LIBS = -lcfitsio -lparammm
INCS = -I/opt/local/include
CXX = g++
CXXFLAGS = -std=c++11 -O2 -g -Wall $(INCS)
LDR = g++
LDRFLAGS = -L/opt/local/lib -Lparammm $(LIBS)

cc.o:
	$(CXX) $(CXXFLAGS) $<

##############################################################################
# you probably don't need to change anything below here

default: all

programs= \
	contbin \
	accumulate_smooth \
	accumulate_smooth_expmap \
	make_region_files \
	paint_output_images \
	dumpdata \
	exposure_smooth \
	accumulate_smooth_expcorr \
	accumulate_counts \
	adaptive_gaussian_smooth
all: $(programs)

clean:
	-rm -f *.o parammm/*.o parammm/*.a $(programs)

install:
	install $(programs) $(bindir)

accumulate_counts.o: accumulate_counts.cc
exposure_smooth.o: exposure_smooth.cc
adaptive_gaussian_smooth.o: adaptive_gaussian_smooth.cc
dumpdata.o: dumpdata.cc
binner.o: point.hh binner.cc binner.hh misc.hh bin.hh \
	scrubber.hh terminal.hh
contbin.o: binner.hh contbin.cc misc.hh
flux_estimator.o: flux_estimator.cc misc.hh flux_estimator.hh
bin.o: bin.hh bin.cc
scrubber.o: scrubber.cc scrubber.hh bin.hh
terminal.o: terminal.hh terminal.cc

accumulate_counts_objs=accumulate_counts.o fitsio_simple.o memimage.o
accumulate_counts: $(accumulate_counts_objs)  parammm/libparammm.a
	$(LDR) -o accumulate_counts $(accumulate_counts_objs) $(LDRFLAGS)


adaptive_gaussian_smooth_objs=adaptive_gaussian_smooth.o fitsio_simple.o memimage.o

adaptive_gaussian_smooth: $(adaptive_gaussian_smooth_objs)  parammm/libparammm.a
	$(LDR) -o adaptive_gaussian_smooth $(adaptive_gaussian_smooth_objs) $(LDRFLAGS)

exposure_smooth_objs=exposure_smooth.o fitsio_simple.o memimage.o

exposure_smooth: $(exposure_smooth_objs)  parammm/libparammm.a
	$(LDR) -o exposure_smooth $(exposure_smooth_objs) $(LDRFLAGS)

dumpdata: dumpdata.o fitsio_simple.o
	$(LDR) -o dumpdata fitsio_simple.o dumpdata.o $(LDRFLAGS)

contbin_objs=contbin.o binner.o flux_estimator.o bin.o scrubber.o \
	terminal.o fitsio_simple.o memimage.o

contbin: $(contbin_objs) parammm/libparammm.a
	$(LDR) -o contbin $(contbin_objs) $(LDRFLAGS)

acc_smooth_objs=accumulate_smooth.o flux_estimator.o \
	fitsio_simple.o memimage.o

accumulate_smooth: $(acc_smooth_objs) parammm/libparammm.a
	$(LDR) -o accumulate_smooth $(acc_smooth_objs) $(LDRFLAGS)

acc_smooth_expmap_objs=accumulate_smooth_expmap.o \
	fitsio_simple.o memimage.o

accumulate_smooth_expmap: $(acc_smooth_expmap_objs) parammm/libparammm.a
	$(LDR) -o accumulate_smooth_expmap $(acc_smooth_expmap_objs) \
		$(LDRFLAGS)

acc_smooth_expcorr_objs=accumulate_smooth_expcorr.o \
	fitsio_simple.o memimage.o

accumulate_smooth_expcorr: $(acc_smooth_expcorr_objs) parammm/libparammm.a
	$(LDR) -o accumulate_smooth_expcorr $(acc_smooth_expcorr_objs) \
		$(LDRFLAGS)

make_region_files_objs=make_region_files.o \
        fitsio_simple.o memimage.o

make_region_files: $(make_region_files_objs) parammm/libparammm.a
	$(LDR) -o make_region_files $(make_region_files_objs) \
		$(LDRFLAGS)

make_region_files_polygon_objs=make_region_files_polygon.o \
        fitsio_simple.o memimage.o

make_region_files_polygon: $(make_region_files_polygon_objs) parammm/libparammm.a
	$(LDR) -o make_region_files_polygon $(make_region_files_polygon_objs) \
		$(LDRFLAGS)

paint_output_images_objs=paint_output_images.o \
	fitsio_simple.o memimage.o format_string.o

paint_output_images: $(paint_output_images_objs) parammm/libparammm.a
	$(LDR) -o paint_output_images $(paint_output_images_objs) \
		$(LDRFLAGS)

parammm/libparammm.a:
	$(MAKE) -C parammm libparammm.a
