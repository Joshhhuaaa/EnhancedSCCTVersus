@echo off
PowerShell.exe -Command "& {Start-Process PowerShell.exe -ArgumentList '-ExecutionPolicy Bypass -File ""%~dp0_PC_\Enhanced\ProfileManager.ps1""' -Verb RunAs}"
