#!/bin/bash

CFLAGS="-c -m64 -nostdlib -nostartfiles -nodefaultlibs -ffreestanding -falign-functions=16 -fomit-frame-pointer -mno-red-zone -fno-builtin"

cd src
nasm hello.asm -o ../bin/hello.app -l ../bin/hello-debug.txt
nasm sysinfo.asm -o ../bin/sysinfo.app -l ../bin/sysinfo-debug.txt
nasm euler1.asm -o ../bin/euler1.app
nasm ethtest.asm -o ../bin/ethtest.app
nasm smptest.asm -o ../bin/smptest.app
nasm systest.asm -o ../bin/systest.app
if [ "$(uname)" != "Darwin" ]; then
	gcc $CFLAGS -o crt0.o crt0.c
	gcc $CFLAGS -o libBareMetal.o libBareMetal.c
	gcc $CFLAGS -o helloc.o helloc.c
	ld -T c.ld -o ../bin/helloc.app crt0.o helloc.o libBareMetal.o
	gcc $CFLAGS -o cube3d.o cube3d.c
	ld -T c.ld -o ../bin/cube3d.app crt0.o cube3d.o libBareMetal.o
	gcc $CFLAGS -o graphics.o graphics.c
	ld -T c.ld -o ../bin/graphics.app crt0.o graphics.o
	gcc $CFLAGS -o gavare.o gavare.c
	ld -T c.ld -o ../bin/gavare.app crt0.o gavare.o
	gcc $CFLAGS -o minIP.o minIP.c
	ld -T c.ld -o ../bin/minIP.app crt0.o minIP.o libBareMetal.o
fi
cd ..
