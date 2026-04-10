#!/bin/bash
# Run this inside the iic-osic-tools container from /foss/designs/my_inverter
# It creates the layout, runs DRC, extracts, runs LVS, and exports GDS/LEF
#
# Prerequisites:
#   - my_inverter.sch and my_inverter.sym already in this directory
#   - xschem netlist has been generated (Netlist button in xschem)

set -e
export PDK=sky130A
export PDK_ROOT=/foss/pdks

echo "=== Step 1: Generate SPICE netlist from schematic ==="
xschem --rcfile $PDK_ROOT/sky130A/libs.tech/xschem/xschemrc \
       -n -s -q my_inverter.sch

echo "=== Step 2: Create Magic layout with TCL script ==="
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << 'MAGIC_EOF'

# ---------------------------------------------------------------
# Draw a simple CMOS inverter layout for sky130 1.8V transistors
# NMOS: W=1u L=0.15u   PMOS: W=2u L=0.15u
# ---------------------------------------------------------------

drc off

# --- GND rail (metal1) at bottom ---
box 0 0 4000 400
paint m1
label VSS FreeSans 100 0 0 0 c m1

# --- VDD rail (metal1) at top ---
box 0 5600 4000 6000
paint m1
label VDD FreeSans 100 0 0 0 c m1

# --- NMOS active (ndiffusion) ---
# gate length 150nm = 150 centimicrons in magic coords (at scale 1nm = 1)
# Actually magic sky130A uses centimicrons (1 unit = 10nm with magscale 1 2)
# Let's use a simpler approach: draw pdiff, ndiff, poly, contacts, etc.

# For sky130, it's much easier to use the PDK device generator.
# Let's place the NMOS transistor
box 800 800 2600 2200
getcell sky130_fd_pr__nfet_01v8 -132 -162

# Place the PMOS transistor
box 800 3800 2600 5200
getcell sky130_fd_pr__pfet_01v8 -270 -324

# Wire up with local interconnect and metal1
# Connect NMOS source to GND rail
box 1200 0 1800 1000
paint li
box 1200 0 1800 400
paint m1

# Connect PMOS source to VDD rail
box 1200 5000 1800 6000
paint li
box 1200 5600 1800 6000
paint m1

# Connect drains together (output) via li
box 1200 2000 1800 4000
paint li

# Output label on drain connection
box 1400 2800 1600 3200
label out FreeSans 100 0 0 0 c li

# Connect gates together (input) via poly
box 600 1200 600 4800
paint poly

# Input label
box 400 2800 600 3200
label in FreeSans 100 0 0 0 c poly

# Connect PMOS body (nwell) to VDD
box 0 3400 4000 6000
paint nwell

# Connect NMOS body to GND (pwell is default substrate)

# Save
save my_inverter
drc on
drc check
drc why

MAGIC_EOF

echo ""
echo "=== Step 3: Run DRC ==="
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << 'DRC_EOF'
load my_inverter
select top cell
drc check
drc catchup
drc count
DRC_EOF

echo ""
echo "=== Step 4: Extract for LVS ==="
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << 'EXT_EOF'
load my_inverter
extract do local
extract all
ext2spice lvs
ext2spice
EXT_EOF

echo ""
echo "=== Step 5: Run LVS ==="
netgen -batch lvs \
  "my_inverter.spice my_inverter" \
  "$PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice/sky130_fd_sc_hd.spice my_inverter" \
  $PDK_ROOT/sky130A/libs.tech/netgen/sky130A_setup.tcl \
  my_inverter_lvs.out

echo ""
echo "=== Step 6: Export GDS and LEF ==="
magic -dnull -noconsole -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc << 'GDS_EOF'
load my_inverter
gds write my_inverter.gds
lef write my_inverter.lef
GDS_EOF

echo ""
echo "=== Done! Check my_inverter_lvs.out for LVS results ==="
echo "Output files: my_inverter.mag, my_inverter.gds, my_inverter.lef"
