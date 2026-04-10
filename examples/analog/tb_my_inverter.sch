v {xschem version=3.4.5 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 200 -210 200 -150 { lab=GND}
N 200 -150 320 -150 { lab=GND}
N 320 -210 320 -150 { lab=GND}
N 320 -310 320 -270 { lab=in}
N 200 -490 200 -270 { lab=vdd}
N 320 -150 560 -150 { lab=GND}
N 320 -310 580 -310 { lab=in}
N 560 -290 580 -290 { lab=GND}
N 560 -290 560 -150 { lab=GND}
N 560 -330 580 -330 { lab=vdd}
N 560 -490 560 -330 { lab=vdd}
N 200 -490 560 -490 { lab=vdd}
N 200 -150 200 -130 { lab=GND}
N 560 -150 980 -150 { lab=GND}
N 980 -210 980 -150 { lab=GND}
N 980 -310 980 -270 { lab=out}
N 880 -310 980 -310 { lab=out}
C {sky130_fd_pr/corner.sym} 50 -210 0 0 {name=CORNER only_toplevel=true corner=tt}
C {devices/vsource.sym} 200 -240 0 0 {name=Vvdd value=1.8}
C {devices/lab_wire.sym} 270 -490 0 0 {name=l2 lab=vdd}
C {devices/code_shown.sym} 50 -710 0 0 {name=NGSPICE
only_toplevel=true
value="
.temp 27
.control
tran 0.1n 30n
write tb_my_inverter.raw
.endc
"}
C {devices/lab_wire.sym} 360 -310 0 0 {name=l3 lab=in}
C {devices/vsource.sym} 320 -240 0 0 {name=Vin
value="PULSE(0 1.8 1n 100p 100p 5n 10n)"}
C {my_inverter.sym} 730 -310 0 0 {name=x1}
C {devices/gnd.sym} 200 -130 0 0 {name=l1 lab=GND}
C {devices/capa.sym} 980 -240 0 0 {name=C1
m=1
value=10f
footprint=1206
device="ceramic capacitor"}
C {devices/lab_wire.sym} 950 -310 0 0 {name=l4 lab=out}
C {devices/title.sym} 160 -30 0 0 {name=l5 author="TinyTapeout Workshop"}
C {devices/launcher.sym} 130 -140 0 0 {name=h2
descr="Simulate"
tclcommand="xschem save; xschem netlist; xschem simulate"}
C {devices/launcher.sym} 340 -140 0 0 {name=h5
descr="Load waves"
tclcommand="xschem raw_read $netlist_dir/tb_my_inverter.raw tran"
}
