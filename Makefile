SPC=spcomp

all: TaserJumper.sp	

TaserJumper.sp:
	$(SPC) src/TaserJumper.sp -\;+ -E
	mkdir -p out
	mv src/TaserJumper.smx out/TaserJumper.smx

clean:
	rm -r out
