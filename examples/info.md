## How it works

This design implements a 2-input NAND gate truth table with LED indicators.
Two DIP switch inputs (A and B) feed a NAND gate. The output is displayed on
a red LED. Two additional LEDs mirror the individual input states.

| A | B | NAND Output |
|---|---|-------------|
| 0 | 0 | 1           |
| 0 | 1 | 1           |
| 1 | 0 | 1           |
| 1 | 1 | 0           |

## How to test

1. Toggle ui[0] (Switch A) and ui[1] (Switch B).
2. Observe uo[0] (red LED) for the NAND output.
3. uo[1] and uo[2] show the current input states.
4. Verify all four rows of the truth table above.

## External hardware

None required. The dev board's built-in DIP switches and LEDs are sufficient.
