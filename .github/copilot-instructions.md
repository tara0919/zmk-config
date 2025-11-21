# AI Coding Instructions for ZMK Config

This is a ZMK (Zephyr KeyMap) keyboard firmware configuration repository for the `testkb` shield on the `seeeduino_xiao_ble` board.

## Project Architecture

**ZMK Firmware Stack:**
- ZMK is a modern keyboard firmware built on Zephyr RTOS
- This repo contains **custom board/shield definitions and keymaps**, not the core ZMK framework
- The core ZMK framework is imported via `config/west.yml` from https://github.com/zmkfirmware/zmk

**Directory Structure:**
- `config/` - Custom board/shield definitions (this is the "self" project in west.yml)
  - `boards/shields/testkb/` - Shield-specific device tree and Kconfig files
- `build.yaml` - GitHub Actions matrix (defines which board+shield combinations to build)
- `zephyr/module.yml` - Zephyr build system configuration pointing to custom boards
- `.github/workflows/build.yml` - Delegates to upstream ZMK's build workflow

## Shield Definition Pattern

The `testkb` shield exemplifies the standard ZMK shield structure:

1. **Kconfig.shield** - Feature detection. Enables the shield only when specified:
   ```kconfig
   config SHIELD_TESTKB
       def_bool $(shields_list_contains, testkb)
   ```

2. **Kconfig.defconfig** - Shield-specific defaults (name, features). Conditional on `if SHIELD_TESTKB`.

3. **testkb.overlay** - Device tree overlay defining GPIO matrix, matrix transform, keymaps.
   - Uses ZMK device tree bindings: `zmk,matrix-transform`
   - Must define `columns` and `rows` matching actual GPIO arrays
   - `map` uses `RC(row, col)` macro to define key positions

## Critical Build Information

- **Build Command**: GitHub Actions uses the reusable workflow from `zmkfirmware/zmk/.github/workflows/build-user-config.yml@v0.3`
- **Matrix Definition**: The 3x3 matrix transform in `testkb.overlay` maps physical keys to logical positions
- **Build Artifact**: Outputs `seeeduino_xiao_ble-testkb.uf2` firmware file
- **Local Build**: Would use `west build -b seeeduino_xiao_ble -s zmk/app -- -DSHIELD=testkb` (requires west toolchain)

## Common Patterns

- **Device Tree Overlays**: ZMK heavily uses Zephyr device tree overlays (`.overlay` files) for hardware configuration
- **Kconfig Conditional Logic**: Shield features are gated by `if SHIELD_<NAME>` blocks, evaluated at build time
- **Board + Shield Combinations**: Always specified as pairs in `build.yaml` include entries
- **West Manifest**: `config/west.yml` uses `self: path: config` to mark this directory as a west project

## When Modifying This Config

1. **Adding Keys**: Edit `testkb.overlay` matrix `map` array and adjust `columns`/`rows`
2. **Adding Pins**: Update GPIO definitions in the same `.overlay` file, then recalculate matrix dimensions
3. **Shield Defaults**: Use `Kconfig.defconfig` for keyboard name, encoder counts, or feature flags
4. **Testing**: Push to GitHub; Actions automatically builds for the board/shield pair in `build.yaml`

## Key Files to Reference

- `config/boards/shields/testkb/testkb.overlay` - Hardware matrix definition
- `build.yaml` - Build matrix configuration
- `config/west.yml` - Upstream ZMK dependency and self-project declaration
