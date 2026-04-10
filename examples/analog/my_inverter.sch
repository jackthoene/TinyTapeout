v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 400 -400 400 -360 { lab=gnd}
N 400 -620 400 -580 { lab=vdd}
N 400 -550 470 -550 { lab=vdd}
N 470 -620 470 -550 { lab=vdd}
N 400 -430 470 -430 { lab=gnd}
N 470 -430 470 -360 { lab=gnd}
N 400 -490 400 -460 { lab=out}
N 340 -550 360 -550 { lab=in}
N 340 -490 340 -430 { lab=in}
N 340 -430 360 -430 { lab=in}
N 400 -490 560 -490 { lab=out}
N 400 -620 470 -620 { lab=vdd}
N 400 -360 470 -360 { lab=gnd}
N 340 -550 340 -490 { lab=in}
N 400 -520 400 -490 { lab=out}
N 240 -360 400 -360 { lab=gnd}
N 240 -490 340 -490 { lab=in}
N 240 -620 400 -620 { lab=vdd}
C {devices/ipin.sym} 240 -490 0 0 {name=p1 lab=in}
C {devices/opin.sym} 560 -490 0 0 {name=p2 lab=out}
C {devices/iopin.sym} 240 -620 0 0 {name=p3 lab=vdd}
C {devices/iopin.sym} 240 -360 0 0 {name=p4 lab=gnd}
C {sky130_fd_pr/pfet_01v8.sym} 380 -550 0 0 {name=M1
L=0.15
W=2
nf=1 mult=1
model=pfet_01v8
spiceprefix=X
}
C {sky130_fd_pr/nfet_01v8.sym} 380 -430 0 0 {name=M2
L=0.15
W=1
nf=1 mult=1
model=nfet_01v8
spiceprefix=X
}
