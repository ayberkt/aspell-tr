ASPELL = aspell
ASPELL_FLAGS = 
WORD_LIST_COMPRESS = word-list-compress
DESTDIR = 
dictdir = /usr/lib/aspell
datadir = /usr/lib/aspell

# Generated with Aspell Dicts "proc" script version 0.50.3

lang = tr
version = 0.50-0

cwl_files = tr.cwl
data_files = tr.dat
doc_files = README COPYING Copyright
extra_files = configure info Makefile.pre
multi_files = tr.multi
rws_files = tr.rws


distdir=aspell-${lang}-${version}

all: ${rws_files} ${data_files}

install: all
	mkdir -p ${DESTDIR}${dictdir}/
	cp ${rws_files} ${multi_files} ${DESTDIR}${dictdir}/
	cd ${DESTDIR}${dictdir}/ && chmod 644 ${rws_files} ${multi_files}
	mkdir -p ${DESTDIR}${datadir}/
	cp ${data_files} ${DESTDIR}${datadir}/
	cd ${DESTDIR}${datadir}/ && chmod 644 ${data_files}

clean:
	rm -f ${rws_files}

uninstall:
	-cd ${DESTDIR}${dictdir}/ && rm ${rws_files} ${multi_files} ${link_files}
	-cd ${DESTDIR}${datadir}/ && rm ${data_files}

dist:
	perl proc
	./configure
	@make dist-nogen

dist-nogen:
	-rm -r ${distdir}
	mkdir ${distdir}
	cp -p ${extra_files} ${cwl_files} ${multi_files} ${doc_files} ${data_files} ${distdir}/
	-cp -pr doc/ ${distdir}/
	tar cfj ${distdir}.tar.bz2 ${distdir}/
	rm -r ${distdir}/

distcheck:
	tar xfj ${distdir}.tar.bz2
	cd ${distdir} && ./configure && make

rel:
	mv ${distdir}.tar.bz2 ../rel


tr.rws: tr.cwl


.SUFFIXES: .cwl .rws

.cwl.rws:
	${WORD_LIST_COMPRESS} d < $< | ${ASPELL} ${ASPELL_FLAGS} --lang=tr create master ./$@

