# SPDX-License-Identifier: Apache-2.0

# MCP23xxx GPIO drivers
if(CONFIG_GPIO_MCP230XX)
  zephyr_library()
  zephyr_library_sources(gpio_mcp230xx.c)
  zephyr_library_sources(gpio_mcp23xxx.c)
endif()
