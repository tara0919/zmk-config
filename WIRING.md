# Tarakkie Split Keyboard - Wiring Documentation

## Overview
60キー分割キーボード（左右各30キー）+ トラックボール + ロータリーエンコーダー3個

## Hardware Components

### Controllers (2x)
- **Seeeduino XIAO BLE** (nRF52840)
  - 11 GPIO pins (D0-D10)
  - I2C (SDA/SCL), SPI (MOSI/MISO/SCK)
  - 3.3V operation
  - BLE 5.0 support

### GPIO Expanders (2x)
- **MCP23017** I2C GPIO expander (Switch Science SKU: 7906)
  - 16 GPIO pins (GPA0-7, GPB0-7)
  - I2C address: 0x20
  - 3.3V compatible

### Sensors (Right side only)
- **PMW3610** optical trackball sensor (BOOTH SEIBOKU breakout)
  - SPI interface
  - 3.3V operation

### Encoders
- **Left side (2x):**
  - TTC horizontal encoder (1x)
  - ALPS EC11 vertical encoder (1x)
- **Right side (1x):**
  - TTC horizontal encoder (1x)

### Power Supply
- **DC-DC Boost Converter** (TPS61023)
  - Input: 1.5V (1x AAA battery)
  - Output: 3.3V
  - Sufficient current for BLE + peripherals

---

## Pin Assignments

### Left Side (tarakkie_left)

#### MCU Direct Connections
| MCU Pin | Function | Device |
|---------|----------|--------|
| D0 | I2C SDA | MCP23017 |
| D1 | I2C SCL | MCP23017 |
| D2 | Column 0 | Matrix |
| D3 | Column 1 | Matrix |
| D4 | Column 2 | Matrix |
| D5 | Column 3 | Matrix |
| D6 | Horizontal Encoder SW | TTC Encoder |
| D7 | Vertical Encoder SW | ALPS EC11 |
| D8-D10 | (Reserved) | - |

#### MCP23017 GPIO Assignments (I2C Address: 0x20)
| MCP Pin | Function | Device/Purpose |
|---------|----------|----------------|
| GPA0 | Row 0 | Matrix row |
| GPA1 | Row 1 | Matrix row |
| GPA2 | Row 2 | Matrix row |
| GPA3 | Row 3 | Matrix row |
| GPA4 | Row 4 | Matrix row |
| GPA5 | Row 5 | Matrix row |
| GPA6 | Vertical Encoder A | ALPS EC11 Phase A |
| GPA7 | Vertical Encoder B | ALPS EC11 Phase B |
| GPB0 | Direct Key 0 | Individual key |
| GPB1 | Direct Key 1 | Individual key |
| GPB2 | Direct Key 2 | Individual key |
| GPB3 | Direct Key 3 | Individual key |
| GPB4 | Direct Key 4 | Individual key |
| GPB5 | Direct Key 5 | Individual key |
| GPB6 | Horizontal Encoder A | TTC Phase A |
| GPB7 | Horizontal Encoder B | TTC Phase B |

#### Wiring Summary (Left)
```
XIAO BLE (Left)
├─ D0 (SDA) ────────────┬─ MCP23017 SDA
├─ D1 (SCL) ────────────┼─ MCP23017 SCL
├─ D2-D5 ───────────────┼─ Matrix Columns 0-3
├─ D6 ──────────────────┼─ Horizontal Encoder SW
├─ D7 ──────────────────┼─ Vertical Encoder SW
└─ GND/3.3V ────────────┴─ MCP23017 Power

MCP23017 (Left)
├─ GPA0-GPA5 ───────────── Matrix Rows 0-5
├─ GPA6-GPA7 ───────────── Vertical Encoder A/B
├─ GPB0-GPB5 ───────────── Direct Keys 0-5
└─ GPB6-GPB7 ───────────── Horizontal Encoder A/B
```

---

### Right Side (tarakkie_right)

#### MCU Direct Connections
| MCU Pin | Function | Device |
|---------|----------|--------|
| D0 | I2C SDA | MCP23017 |
| D1 | I2C SCL | MCP23017 |
| D2 | Column 0 | Matrix |
| D3 | Column 1 | Matrix |
| D4 | Column 2 | Matrix |
| D5 | Column 3 | Matrix |
| D6 | Horizontal Encoder SW | TTC Encoder |
| D8 | SPI MOSI | PMW3610 |
| D9 | SPI MISO | PMW3610 |
| D10 | SPI SCK | PMW3610 |
| D7 | SPI CS | PMW3610 |

#### MCP23017 GPIO Assignments (I2C Address: 0x20)
| MCP Pin | Function | Device/Purpose |
|---------|----------|----------------|
| GPA0 | Row 0 | Matrix row |
| GPA1 | Row 1 | Matrix row |
| GPA2 | Row 2 | Matrix row |
| GPA3 | Row 3 | Matrix row |
| GPA4 | Row 4 | Matrix row |
| GPA5 | Row 5 | Matrix row |
| GPA6 | (Reserved) | - |
| GPA7 | (Reserved) | - |
| GPB0 | Direct Key 0 | Individual key |
| GPB1 | Direct Key 1 | Individual key |
| GPB2 | Direct Key 2 | Individual key |
| GPB3 | Direct Key 3 | Individual key |
| GPB4 | Direct Key 4 | Individual key |
| GPB5 | Direct Key 5 | Individual key |
| GPB6 | Horizontal Encoder A | TTC Phase A |
| GPB7 | Horizontal Encoder B | TTC Phase B |

#### Wiring Summary (Right)
```
XIAO BLE (Right - Central)
├─ D0 (SDA) ────────────┬─ MCP23017 SDA
├─ D1 (SCL) ────────────┼─ MCP23017 SCL
├─ D2-D5 ───────────────┼─ Matrix Columns 0-3
├─ D6 ──────────────────┼─ Horizontal Encoder SW
├─ D7 ──────────────────┼─ PMW3610 CS
├─ D8 (MOSI) ───────────┼─ PMW3610 MOSI
├─ D9 (MISO) ───────────┼─ PMW3610 MISO
├─ D10 (SCK) ───────────┼─ PMW3610 SCK
└─ GND/3.3V ────────────┴─ MCP23017 + PMW3610 Power

MCP23017 (Right)
├─ GPA0-GPA5 ───────────── Matrix Rows 0-5
├─ GPB0-GPB5 ───────────── Direct Keys 0-5
└─ GPB6-GPB7 ───────────── Horizontal Encoder A/B
```

---

## Key Matrix Layout

### Physical Key Arrangement (30 keys per side)

```
Left Side (30 keys):
┌────┬────┬────┬────┐
│ Q  │ W  │ E  │ R  │  Matrix 4×6 (24 keys)
├────┼────┼────┼────┤
│ A  │ S  │ D  │ F  │
├────┼────┼────┼────┤
│ Z  │ X  │ C  │ V  │
├────┼────┼────┼────┤
│ESC │TAB │SHFT│CTRL│
├────┼────┼────┼────┤
│ L1 │ L2 │ L3 │ L4 │
├────┼────┼────┼────┤
│SPC │BSPC│RET │GUI │
└────┴────┴────┴────┘
┌────┬────┬────┬────┬────┬────┐
│ T  │ G  │ B  │ALT │DEL │HOME│  Direct keys (6)
└────┴────┴────┴────┴────┴────┘

Right Side (30 keys):
┌────┬────┬────┬────┐
│ 7  │ 8  │ 9  │ -  │  Matrix 4×6 (24 keys)
├────┼────┼────┼────┤
│ 4  │ 5  │ 6  │ +  │
├────┼────┼────┼────┤
│ 1  │ 2  │ 3  │ *  │
├────┼────┼────┼────┤
│ 0  │ .  │ ,  │ /  │
├────┼────┼────┼────┤
│ ↑  │ ↓  │ ←  │ →  │
├────┼────┼────┼────┤
│PgUp│PgDn│Home│End │
└────┴────┴────┴────┘
┌────┬────┬────┬────┬────┬────┐
│RET │BSPC│DEL │INS │RALT│CTRL│  Direct keys (6)
└────┴────┴────┴────┴────┴────┘
```

### Matrix Scanning Pattern

**4 Columns (MCU GPIO D2-D5) × 6 Rows (MCP GPA0-5)**
- Total matrix keys: 24
- Scanning: Column outputs LOW, read row inputs
- Diodes: COL2ROW (cathode to row, anode to column)

**6 Direct Keys (MCP GPB0-5)**
- No matrix scanning required
- Direct GPIO input with pull-up resistors
- Active-low (press = LOW signal)

---

## Encoder Connections

### TTC Horizontal Encoders (both sides)
```
Encoder Pin → Connection
─────────────────────────
A phase     → MCP GPB6
B phase     → MCP GPB7
Switch (SW) → MCU D6
Common      → GND
```

### ALPS EC11 Vertical Encoder (left side only)
```
Encoder Pin → Connection
─────────────────────────
A phase     → MCP GPA6
B phase     → MCP GPA7
Switch (SW) → MCU D7
Common      → GND
```

**Note:** A/B phases connected to MCP23017 to save MCU pins. Switch pins connected directly to MCU for reliable debouncing.

---

## PMW3610 Trackball Sensor (Right side only)

### SPI Connections
```
PMW3610 Pin → XIAO BLE Pin
────────────────────────────
MOSI        → D8 (SPI MOSI)
MISO        → D9 (SPI MISO)
SCK         → D10 (SPI SCK)
CS          → D7 (GPIO)
VDD         → 3.3V
GND         → GND
```

### Additional Considerations
- Maximum SPI clock: 2 MHz for PMW3610
- Motion interrupt pin (optional): Not currently used
- Lens height: ~2.5mm above sensor surface

---

## Power Supply Wiring

### DC-DC Boost Converter (TPS61023)
```
Input:  1× AAA battery (1.5V nominal)
Output: 3.3V regulated
        
Connections:
Battery (+) → Converter IN+
Battery (-) → Converter IN- (GND)
Converter OUT+ → XIAO BLE 3V3 pin
Converter OUT- → XIAO BLE GND
```

### Current Budget (per side)
- XIAO BLE (active BLE): ~10 mA
- MCP23017: ~1 mA
- PMW3610 (right only): ~15 mA
- Key matrix LEDs (if added): ~20 mA per LED
- **Total estimate:** 30-50 mA per side

---

## I2C Bus Configuration

### MCP23017 Address Selection
- A0, A1, A2 pins → GND (address 0x20)
- Both left and right use same address (separate I2C buses)

### Pull-up Resistors
- 4.7kΩ on SDA and SCL lines (required for I2C)
- Can use internal MCU pull-ups if external resistors unavailable

---

## Build and Flash Instructions

### Building Firmware
```bash
# In repository root
west build -b seeeduino_xiao_ble -s zmk/app -- -DSHIELD=tarakkie_left
west build -b seeeduino_xiao_ble -s zmk/app -- -DSHIELD=tarakkie_right
```

Or use GitHub Actions:
1. Push changes to repository
2. Actions builds both `tarakkie_left` and `tarakkie_right`
3. Download `.uf2` files from Actions artifacts

### Flashing
1. Double-tap RESET button on XIAO BLE
2. Board appears as USB mass storage device
3. Copy `.uf2` file to the drive
4. Board automatically reboots with new firmware

### Pairing Split Halves
1. Flash right side (central) first
2. Flash left side (peripheral) second
3. Power on both sides
4. They should auto-pair via BLE
5. Check BLE connection LED (if configured)

---

## Troubleshooting

### Keys Not Responding
- Check matrix diode orientation (band = cathode → row)
- Verify MCP23017 I2C address (A0/A1/A2 = GND)
- Test I2C communication with oscilloscope/logic analyzer
- Ensure all GND connections are common

### Encoders Not Working
- Verify A/B phase wiring (swap if rotation direction inverted)
- Check pull-up resistors on encoder lines
- Test with multimeter: rotating should toggle voltage

### Trackball Not Detected
- Verify SPI connections (MOSI/MISO not swapped)
- Check CS pin is correctly assigned
- Ensure lens is clean and at correct height
- Test SPI communication at lower clock speeds

### Split Halves Not Pairing
- Clear BLE bonds: Hold BT_CLR key combination
- Reflash both halves in correct order (right first)
- Check for BLE interference (2.4 GHz WiFi, etc.)
- Verify both sides powered on simultaneously

---

## Keymap File Location
- **Shared keymap:** `config/tarakkie_split.keymap`
- Keymap defines 5 layers (0-4):
  - Layer 0: Default (QWERTY + numpad)
  - Layer 1: Function keys + media
  - Layer 2: Symbols
  - Layer 3: Navigation
  - Layer 4: System (Bluetooth controls)

---

## License
MIT License - See repository LICENSE file

## Author
Created for Seeeduino XIAO BLE custom split keyboard project
