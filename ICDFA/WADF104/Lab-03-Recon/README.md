# WADF104 Lab 03 — Reconnaissance Tool

## Objective

The objective of this practical is to develop a Bash-based
reconnaissance tool that provides a menu-driven interface for
authorised reconnaissance activities.

## Tools

The script provides the following options:

1. WhatWeb
2. Nmap
3. DIRB
4. Exit

## Requirements Demonstrated

- Bash scripting
- Target IP/domain input
- Menu-driven tool selection
- WhatWeb execution
- Nmap execution
- DIRB execution
- Invalid selection handling
- Executable script permission
- Direct execution using `./recon_tool.sh`

## How the Script Works
The recon_tool.sh script is a Bash-based reconnaissance tool. First, it asks the user to enter a target IP address or an authorised domain. After receiving the target, it displays a menu with different reconnaissance options.
The user can select WhatWeb, Nmap, or DIRB to perform reconnaissance on the target. The selected tool runs against the target and displays its results. If the user enters an invalid menu option, the script displays an error message and allows the user to make another selection.
The Exit option allows the user to safely close the script. The script also checks that the required reconnaissance tools are available before attempting to run them.

## Source Code
The completed Bash source code is available in:
`recon_tool.sh`

## Execution

The script is executed using:

```bash
./recon_tool.sh
