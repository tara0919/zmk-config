# Tarakkie 分割キーボード - 配線ドキュメント
# Tarakkie Split Keyboard - Wiring Documentation

## 概要 / Overview

**日本語:**
60キー分割キーボード（左右各30キー）+ トラックボール + ロータリーエンコーダー3個

このドキュメントでは Tarakkie 分割キーボードの物理配線、ピン配置、部品選定の詳細を説明します。
左右独立した2つのユニットで構成され、BLE（Bluetooth Low Energy）で無線接続します。

**キーレイアウト（片側）:**
- マトリクス部分: 4行 × 6列 = 24キー
- ダイレクトキー: 6キー
- 合計: 30キー（片側）

**English:**
60-key split keyboard (30 keys per side) + trackball + 3 rotary encoders

**Key Layout (per side):**
- Matrix: 4 rows × 6 columns = 24 keys
- Direct keys: 6 keys
- Total: 30 keys per side

---

## ハードウェア構成部品 / Hardware Components

### コントローラ（左右各1個、計2個）/ Controllers (2x)

- **Seeeduino XIAO BLE** (nRF52840)
  - 11本の GPIO ピン (D0〜D10) / 11 GPIO pins (D0-D10)
  - I2C と SPI インターフェース搭載 / I2C (SDA/SCL), SPI (MOSI/MISO/SCK)
  - 動作電圧 3.3V / 3.3V operation
  - BLE 5.0 対応（無線通信用）/ BLE 5.0 support

### GPIO 拡張チップ（左右各1個、計2個）/ GPIO Expanders (2x)

- **MCP23017** I2C GPIO expander (Switch Science SKU: 7906)
  - 16本の GPIO (GPA0〜7, GPB0〜7 の2バンク構成) / 16 GPIO pins (GPA0-7, GPB0-7)
  - I2C アドレス: 0x20（A0/A1/A2 を GND 接続で固定）/ I2C address: 0x20
  - 3.3V 動作対応 / 3.3V compatible

### センサー（右手側のみ）/ Sensors (Right side only)

- **PMW3610** 光学式トラックボールセンサー（BOOTH「SEIBOKU」のブレイクアウト基板）
  - PMW3610 optical trackball sensor (BOOTH SEIBOKU breakout)
  - SPI 通信方式 / SPI interface
  - 3.3V 動作 / 3.3V operation

### ロータリーエンコーダー / Encoders

- **左手側（2個）/ Left side (2x):**
  - TTC 水平エンコーダー（マウス用）× 1 / TTC horizontal encoder (1x)
  - ALPS EC11 垂直エンコーダー × 1 / ALPS EC11 vertical encoder (1x)
- **右手側（1個）/ Right side (1x):**
  - TTC 水平エンコーダー（マウス用）× 1 / TTC horizontal encoder (1x)

### 電源回路 / Power Supply

- **DC-DC 昇圧コンバーター**（TPS61023 または互換品）/ DC-DC Boost Converter (TPS61023)
  - 入力: 1.5V（単4電池1本）/ Input: 1.5V (1x AAA battery)
  - 出力: 3.3V 安定化 / Output: 3.3V regulated
  - BLE 通信 + 周辺機器に十分な電流供給能力 / Sufficient current for BLE + peripherals

---

## ピン配置 / Pin Assignments

### 左手側（tarakkie_left）/ Left Side

#### MCU 直結ピン / MCU Direct Connections

| MCU ピン<br>MCU Pin | 機能<br>Function | 接続先デバイス<br>Device |
|---------|----------|--------|
| D0 | I2C データ線<br>I2C SDA | MCP23017 |
| D1 | I2C クロック線<br>I2C SCL | MCP23017 |
| D2 | マトリクス行 0<br>Row 0 | キースイッチマトリクス<br>Matrix |
| D3 | マトリクス行 1<br>Row 1 | キースイッチマトリクス<br>Matrix |
| D4 | マトリクス行 2<br>Row 2 | キースイッチマトリクス<br>Matrix |
| D5 | マトリクス行 3<br>Row 3 | キースイッチマトリクス<br>Matrix |
| D6 | 水平エンコーダーSW<br>Horizontal Encoder SW | TTC エンコーダー<br>TTC Encoder |
| D7 | 垂直エンコーダーSW<br>Vertical Encoder SW | ALPS EC11 |
| D8-D10 | （予約）<br>(Reserved) | - |

#### MCP23017 GPIO 配置（I2C アドレス: 0x20）/ MCP23017 GPIO Assignments

| MCP ピン<br>MCP Pin | 機能<br>Function | デバイス/用途<br>Device/Purpose |
|---------|----------|----------------|
| GPA0 | 列 0<br>Column 0 | マトリクス列<br>Matrix column |
| GPA1 | 列 1<br>Column 1 | マトリクス列<br>Matrix column |
| GPA2 | 列 2<br>Column 2 | マトリクス列<br>Matrix column |
| GPA3 | 列 3<br>Column 3 | マトリクス列<br>Matrix column |
| GPA4 | 列 4<br>Column 4 | マトリクス列<br>Matrix column |
| GPA5 | 列 5<br>Column 5 | マトリクス列<br>Matrix column |
| GPA6 | 垂直エンコーダー A相<br>Vertical Encoder A | ALPS EC11 Phase A |
| GPA7 | 垂直エンコーダー B相<br>Vertical Encoder B | ALPS EC11 Phase B |
| GPB0 | 個別キー 0<br>Direct Key 0 | 個別キー<br>Individual key |
| GPB1 | 個別キー 1<br>Direct Key 1 | 個別キー<br>Individual key |
| GPB2 | 個別キー 2<br>Direct Key 2 | 個別キー<br>Individual key |
| GPB3 | 個別キー 3<br>Direct Key 3 | 個別キー<br>Individual key |
| GPB4 | 個別キー 4<br>Direct Key 4 | 個別キー<br>Individual key |
| GPB5 | 個別キー 5<br>Direct Key 5 | 個別キー<br>Individual key |
| GPB6 | 水平エンコーダー A相<br>Horizontal Encoder A | TTC Phase A |
| GPB7 | 水平エンコーダー B相<br>Horizontal Encoder B | TTC Phase B |

#### 配線概要（左手側）/ Wiring Summary (Left)

```
XIAO BLE (左 / Left)
├─ D0 (SDA) ────────────┬─ MCP23017 SDA
├─ D1 (SCL) ────────────┼─ MCP23017 SCL
├─ D2-D5 ───────────────┼─ マトリクス行 0-3 / Matrix Rows 0-3
├─ D6 ──────────────────┼─ 水平エンコーダーSW / Horizontal Encoder SW
├─ D7 ──────────────────┼─ 垂直エンコーダーSW / Vertical Encoder SW
└─ GND/3.3V ────────────┴─ MCP23017 電源 / Power

MCP23017 (左 / Left)
├─ GPA0-GPA5 ───────────── マトリクス列 0-5 / Matrix Columns 0-5
├─ GPA6-GPA7 ───────────── 垂直エンコーダー A/B / Vertical Encoder A/B
├─ GPB0-GPB5 ───────────── 個別キー 0-5 / Direct Keys 0-5
└─ GPB6-GPB7 ───────────── 水平エンコーダー A/B / Horizontal Encoder A/B
```

---

### 右手側（tarakkie_right）/ Right Side

#### MCU 直結ピン / MCU Direct Connections

| MCU ピン<br>MCU Pin | 機能<br>Function | 接続先デバイス<br>Device |
|---------|----------|--------|
| D0 | I2C データ線<br>I2C SDA | MCP23017 |
| D1 | I2C クロック線<br>I2C SCL | MCP23017 |
| D2 | マトリクス行 0<br>Row 0 | キースイッチマトリクス<br>Matrix |
| D3 | マトリクス行 1<br>Row 1 | キースイッチマトリクス<br>Matrix |
| D4 | マトリクス行 2<br>Row 2 | キースイッチマトリクス<br>Matrix |
| D5 | マトリクス行 3<br>Row 3 | キースイッチマトリクス<br>Matrix |
| D6 | 水平エンコーダーSW<br>Horizontal Encoder SW | TTC エンコーダー<br>TTC Encoder |
| D7 | SPI チップセレクト<br>SPI CS | PMW3610 |
| D8 | SPI MOSI | PMW3610 |
| D9 | SPI MISO | PMW3610 |
| D10 | SPI クロック<br>SPI SCK | PMW3610 |

#### MCP23017 GPIO 配置（I2C アドレス: 0x20）/ MCP23017 GPIO Assignments

| MCP ピン<br>MCP Pin | 機能<br>Function | デバイス/用途<br>Device/Purpose |
|---------|----------|----------------|
| GPA0-5 | 列 0-5<br>Column 0-5 | マトリクス列<br>Matrix columns |
| GPA6 | （予約）<br>(Reserved) | - |
| GPA7 | （予約）<br>(Reserved) | - |
| GPB0-5 | 個別キー 0-5<br>Direct Key 0-5 | 個別キー<br>Individual keys |
| GPB6 | 水平エンコーダー A相<br>Horizontal Encoder A | TTC Phase A |
| GPB7 | 水平エンコーダー B相<br>Horizontal Encoder B | TTC Phase B |

#### 配線概要（右手側）/ Wiring Summary (Right)

```
XIAO BLE (右 - Central / Right - Central)
├─ D0 (SDA) ────────────┬─ MCP23017 SDA
├─ D1 (SCL) ────────────┼─ MCP23017 SCL
├─ D2-D5 ───────────────┼─ マトリクス行 0-3 / Matrix Rows 0-3
├─ D6 ──────────────────┼─ 水平エンコーダーSW / Horizontal Encoder SW
├─ D7 ──────────────────┼─ PMW3610 CS
├─ D8 (MOSI) ───────────┼─ PMW3610 MOSI
├─ D9 (MISO) ───────────┼─ PMW3610 MISO
├─ D10 (SCK) ───────────┼─ PMW3610 SCK
└─ GND/3.3V ────────────┴─ MCP23017 + PMW3610 電源 / Power

MCP23017 (右 / Right)
├─ GPA0-GPA5 ───────────── マトリクス列 0-5 / Matrix Columns 0-5
├─ GPB0-GPB5 ───────────── 個別キー 0-5 / Direct Keys 0-5
└─ GPB6-GPB7 ───────────── 水平エンコーダー A/B / Horizontal Encoder A/B
```

---

## キーマトリクス配置 / Key Matrix Layout

### 物理的なキー配置（片側30キー）/ Physical Key Arrangement (30 keys per side)

**マトリクス構成: 4行 × 6列 + 6個別キー = 30キー（片側）**
**Matrix Configuration: 4 rows × 6 columns + 6 direct keys = 30 keys (per side)**

```
左手側（30キー）/ Left Side (30 keys):
┌────┬────┬────┬────┬────┬────┐
│ Q  │ W  │ E  │ R  │ T  │ Y  │  行0 / Row 0
├────┼────┼────┼────┼────┼────┤
│ A  │ S  │ D  │ F  │ G  │ H  │  行1 / Row 1
├────┼────┼────┼────┼────┼────┤
│ Z  │ X  │ C  │ V  │ B  │ N  │  行2 / Row 2
├────┼────┼────┼────┼────┼────┤
│ESC │TAB │SHFT│CTRL│ALT │GUI │  行3 / Row 3
└────┴────┴────┴────┴────┴────┘
 列0  列1  列2  列3  列4  列5
 C0   C1   C2   C3   C4   C5

個別キー（6個）/ Direct keys (6):
┌────┬────┬────┬────┬────┬────┐
│ L1 │ L2 │ L3 │ L4 │SPC │BSPC│
└────┴────┴────┴────┴────┴────┘

右手側（30キー）/ Right Side (30 keys):
┌────┬────┬────┬────┬────┬────┐
│ 7  │ 8  │ 9  │ -  │ =  │BSPC│  行0 / Row 0
├────┼────┼────┼────┼────┼────┤
│ 4  │ 5  │ 6  │ +  │ *  │ /  │  行1 / Row 1
├────┼────┼────┼────┼────┼────┤
│ 1  │ 2  │ 3  │ .  │ ,  │RET │  行2 / Row 2
├────┼────┼────┼────┼────┼────┤
│ 0  │ ↑  │ ↓  │ ←  │ →  │DEL │  行3 / Row 3
└────┴────┴────┴────┴────┴────┘
 列0  列1  列2  列3  列4  列5
 C0   C1   C2   C3   C4   C5

個別キー（6個）/ Direct keys (6):
┌────┬────┬────┬────┬────┬────┐
│PgUp│PgDn│Home│End │RALT│CTRL│
└────┴────┴────┴────┴────┴────┘
```

### マトリクススキャン方式 / Matrix Scanning Pattern

**6列（MCP GPA0-5）× 4行（MCU GPIO D2-D5）/ 6 Columns (MCP GPA0-5) × 4 Rows (MCU GPIO D2-D5)**
- マトリクスキー合計: 24個 / Total matrix keys: 24
- スキャン方式: 列を HIGH 出力、行を入力読み取り / Scanning: Column outputs HIGH, read row inputs
- ダイオード: COL2ROW（カソードを行、アノードを列に接続）/ Diodes: COL2ROW (cathode to row, anode to column)

**6個の個別キー（MCP GPB0-5）/ 6 Direct Keys (MCP GPB0-5)**
- マトリクススキャン不要 / No matrix scanning required
- プルアップ抵抗付き GPIO 直接入力 / Direct GPIO input with pull-up resistors
- アクティブ LOW（押下 = LOW 信号）/ Active-low (press = LOW signal)

---

## エンコーダー接続 / Encoder Connections

### TTC 水平エンコーダー（両側）/ TTC Horizontal Encoders (both sides)

```
エンコーダーピン → 接続先 / Encoder Pin → Connection
──────────────────────────────────────────
A 相 / A phase     → MCP GPB6
B 相 / B phase     → MCP GPB7
スイッチ (SW) / Switch (SW) → MCU D6
共通 / Common      → GND
```

### ALPS EC11 垂直エンコーダー（左手側のみ）/ ALPS EC11 Vertical Encoder (left side only)

```
エンコーダーピン → 接続先 / Encoder Pin → Connection
──────────────────────────────────────────
A 相 / A phase     → MCP GPA6
B 相 / B phase     → MCP GPA7
スイッチ (SW) / Switch (SW) → MCU D7
共通 / Common      → GND
```

**注記 / Note:** A/B相は MCP23017 に接続して MCU ピンを節約。スイッチは確実なデバウンスのため MCU に直接接続。
A/B phases connected to MCP23017 to save MCU pins. Switch pins connected directly to MCU for reliable debouncing.

---

## PMW3610 トラックボールセンサー（右手側のみ）/ PMW3610 Trackball Sensor (Right side only)

### SPI 接続 / SPI Connections

```
PMW3610 ピン → XIAO BLE ピン / PMW3610 Pin → XIAO BLE Pin
────────────────────────────────────────────────────────
MOSI        → D8 (SPI MOSI)
MISO        → D9 (SPI MISO)
SCK         → D10 (SPI SCK)
CS          → D7 (GPIO)
VDD         → 3.3V
GND         → GND
```

### 追加の考慮事項 / Additional Considerations

- 最大 SPI クロック: PMW3610 は 2 MHz まで / Maximum SPI clock: 2 MHz for PMW3610
- モーション割り込みピン（オプション）: 現在未使用 / Motion interrupt pin (optional): Not currently used
- レンズ高さ: センサー表面から約 2.5mm / Lens height: ~2.5mm above sensor surface

---

## 電源配線 / Power Supply Wiring

### DC-DC 昇圧コンバーター（TPS61023）/ DC-DC Boost Converter (TPS61023)

```
入力: 単4電池1本（公称1.5V）/ Input:  1× AAA battery (1.5V nominal)
出力: 安定化3.3V / Output: 3.3V regulated
        
接続 / Connections:
電池 (+) / Battery (+) → コンバーター IN+ / Converter IN+
電池 (-) / Battery (-) → コンバーター IN- (GND) / Converter IN- (GND)
コンバーター OUT+ / Converter OUT+ → XIAO BLE 3V3 ピン / XIAO BLE 3V3 pin
コンバーター OUT- / Converter OUT- → XIAO BLE GND
```

### 消費電流見積もり（片側）/ Current Budget (per side)

- XIAO BLE（BLE アクティブ時）: 約 10 mA / XIAO BLE (active BLE): ~10 mA
- MCP23017: 約 1 mA / MCP23017: ~1 mA
- PMW3610（右側のみ）: 約 15 mA / PMW3610 (right only): ~15 mA
- キーマトリクス LED（追加する場合）: LED 1個あたり約 20 mA / Key matrix LEDs (if added): ~20 mA per LED
- **合計見積もり / Total estimate:** 片側 30-50 mA / 30-50 mA per side

---

## I2C バス設定 / I2C Bus Configuration

### MCP23017 アドレス選択 / MCP23017 Address Selection

- A0, A1, A2 ピン → GND（アドレス 0x20）/ A0, A1, A2 pins → GND (address 0x20)
- 左右両方とも同じアドレスを使用（別々の I2C バス）/ Both left and right use same address (separate I2C buses)

### プルアップ抵抗 / Pull-up Resistors

- SDA と SCL ラインに 4.7kΩ（I2C に必須）/ 4.7kΩ on SDA and SCL lines (required for I2C)
- 外部抵抗が使えない場合は MCU 内蔵プルアップも可 / Can use internal MCU pull-ups if external resistors unavailable

---

## ビルドと書き込み手順 / Build and Flash Instructions

### ファームウェアのビルド / Building Firmware

```bash
# リポジトリルートで / In repository root
west build -b seeeduino_xiao_ble -s zmk/app -- -DSHIELD=tarakkie_left
west build -b seeeduino_xiao_ble -s zmk/app -- -DSHIELD=tarakkie_right
```

**または GitHub Actions を使用 / Or use GitHub Actions:**
1. 変更をリポジトリにプッシュ / Push changes to repository
2. Actions が `tarakkie_left` と `tarakkie_right` の両方をビルド / Actions builds both `tarakkie_left` and `tarakkie_right`
3. Actions の成果物から `.uf2` ファイルをダウンロード / Download `.uf2` files from Actions artifacts

### 書き込み / Flashing

1. XIAO BLE の RESET ボタンをダブルタップ / Double-tap RESET button on XIAO BLE
2. USB マスストレージデバイスとして表示される / Board appears as USB mass storage device
3. `.uf2` ファイルをドライブにコピー / Copy `.uf2` file to the drive
4. 自動的に新しいファームウェアで再起動 / Board automatically reboots with new firmware

### 分割の左右をペアリング / Pairing Split Halves

1. 右側（central）を最初に書き込み / Flash right side (central) first
2. 左側（peripheral）を2番目に書き込み / Flash left side (peripheral) second
3. 両側の電源を入れる / Power on both sides
4. BLE で自動ペアリングされる / They should auto-pair via BLE
5. BLE 接続 LED を確認（設定されている場合）/ Check BLE connection LED (if configured)

---

## トラブルシューティング / Troubleshooting

### キーが反応しない / Keys Not Responding

- マトリクスダイオードの向きを確認（帯 = カソード → 行）/ Check matrix diode orientation (band = cathode → row)
- MCP23017 の I2C アドレスを確認（A0/A1/A2 = GND）/ Verify MCP23017 I2C address (A0/A1/A2 = GND)
- オシロスコープ/ロジックアナライザで I2C 通信をテスト / Test I2C communication with oscilloscope/logic analyzer
- すべての GND 接続が共通であることを確認 / Ensure all GND connections are common

### エンコーダーが動作しない / Encoders Not Working

- A/B 相の配線を確認（回転方向が逆なら入れ替え）/ Verify A/B phase wiring (swap if rotation direction inverted)
- エンコーダーラインのプルアップ抵抗を確認 / Check pull-up resistors on encoder lines
- テスターでテスト: 回転時に電圧がトグルするはず / Test with multimeter: rotating should toggle voltage

### トラックボールが検出されない / Trackball Not Detected

- SPI 接続を確認（MOSI/MISO が入れ替わっていないか）/ Verify SPI connections (MOSI/MISO not swapped)
- CS ピンが正しく割り当てられているか確認 / Check CS pin is correctly assigned
- レンズが清潔で正しい高さにあることを確認 / Ensure lens is clean and at correct height
- より低いクロック速度で SPI 通信をテスト / Test SPI communication at lower clock speeds

### 分割の左右がペアリングしない / Split Halves Not Pairing

- BLE ボンドをクリア: BT_CLR キー組み合わせを長押し / Clear BLE bonds: Hold BT_CLR key combination
- 正しい順序で両方を再書き込み（右が先）/ Reflash both halves in correct order (right first)
- BLE 干渉を確認（2.4 GHz WiFi など）/ Check for BLE interference (2.4 GHz WiFi, etc.)
- 両側が同時に電源オンされているか確認 / Verify both sides powered on simultaneously

---

## キーマップファイルの場所 / Keymap File Location

- **共有キーマップ / Shared keymap:** `config/tarakkie_split.keymap`
- キーマップは5レイヤー (0-4) を定義 / Keymap defines 5 layers (0-4):
  - レイヤー0 / Layer 0: デフォルト（QWERTY + テンキー）/ Default (QWERTY + numpad)
  - レイヤー1 / Layer 1: ファンクションキー + メディア / Function keys + media
  - レイヤー2 / Layer 2: シンボル / Symbols
  - レイヤー3 / Layer 3: ナビゲーション / Navigation
  - レイヤー4 / Layer 4: システム（Bluetooth 制御）/ System (Bluetooth controls)

---

## ライセンス / License

MIT License - リポジトリの LICENSE ファイルを参照 / See repository LICENSE file

## 作者 / Author

Seeeduino XIAO BLE カスタム分割キーボードプロジェクト用に作成 / Created for Seeeduino XIAO BLE custom split keyboard project
