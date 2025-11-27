# SPDX-License-Identifier: Apache-2.0

# MCP23xxx GPIO drivers
zephyr_library_sources_ifdef(CONFIG_GPIO_MCP230XX gpio_mcp230xx.c)
zephyr_library_sources_ifdef(CONFIG_GPIO_MCP23XXX gpio_mcp23xxx.c)
