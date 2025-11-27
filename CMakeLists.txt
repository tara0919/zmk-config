# SPDX-License-Identifier: Apache-2.0

# Add custom drivers
if(CONFIG_GPIO_MCP230XX)
  add_subdirectory(drivers/gpio)
endif()
