;------------------------------------------
;--- Heat and home the bed
;------------------------------------------
;M502                   ; Reset settings to configuration defaults...
;M500                   ; ...and Save to EEPROM. Use this on a new install.
;M501                   ; Read back in the saved EEPROM.
M140 S65                ; starting by heating the bed for nominal mesh accuracy
M117 Homing all axes    ; send message to printer display
G28                     ; home all axes
M117 Heating the bed    ; send message to printer display
M190 S65                ; waiting until the bed is fully warmed up

;------------------------------------------
;--- Probe
;------------------------------------------
M300 S1000 P500         ; chirp to indicate bed mesh levels is initializing
M117 Creating the bed mesh levels   ; send message to printer display
M155 S30                ; reduce temperature reporting rate to reduce output pollution
@BEDLEVELVISUALIZER	    ; tell the plugin to watch for reported mesh
G29 P1                  ; automatically populate mesh with all reachable points
;G29 P3                  ; infer the rest of the mesh values
;G29 P3                  ; infer the rest of the mesh values

;------------------------------------------
;--- Show and store data
;------------------------------------------
G29 T                   ; View the Z compensation values.
G29 S1                  ; Store the mesh in EEPROM slot 1
G29 A                   ; Activate the UBL System.
M500                    ; store on EEPROM

;------------------------------------------
;--- Exit actions
;------------------------------------------
M155 S3                 ; reset temperature reporting
M140 S0                 ; cooling down the bed
M300 S440 P200          ; make calibration completed tones
M300 S660 P250
M300 S880 P300
M117 Bed mesh levels completed ; send message to printer display

;---------------------------------------------
;--- Fine Tuning of the mesh happens below ---
;---------------------------------------------
; G26 C B65       ; Produce mesh validation pattern with primed nozzle (5mm) and filament diameter 3mm
;                       ; PLA temperatures are assumed unless you specify, e.g., B 105 H 225 for ABS Plastic
; G29 P4 T              ; Move nozzle to 'bad' areas and fine tune the values if needed
;                       ; Repeat G26 and G29 P4 T  commands as needed.

; G29 S1                ; Save UBL mesh values to EEPROM.
; M500                  ; Resave UBL's state information.
