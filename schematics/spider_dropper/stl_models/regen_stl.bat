REM Regenerates the STL files for previewing the PCB in OpenSCAD.

REM Assumes kicad-cli.exe can be found in PATH.  Assumes input and output files
REM are relative to the directory with this batch file.

REM Note that the `--user-origin` value was computed by the GUI interface when
REM I chose "Board center origin".  If the board geometry changes, it may be
REM necessary to generate the STLs from KiCAD's PCB Editor and to grab the new
REM command lines.  The command line interface doesn't offer a "board center
REM origin" option.

kicad-cli pcb export stl --subst-models --no-components --user-origin='149.900000x108.300000mm' -f -o "%~dp0\pcb_green.stl" "%~dp0..\spider_dropper.kicad_pcb"

kicad-cli pcb export stl --subst-models --no-board-body --include-silkscreen --user-origin='149.900000x108.300000mm' -f -o "%~dp0\pcb_white.stl" "%~dp0..\spider_dropper.kicad_pcb"
