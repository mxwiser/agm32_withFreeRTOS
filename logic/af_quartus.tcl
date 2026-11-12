# AGM_QUARTUS_GUARD: added by build_logic.bat after project generation.
set agm_version [exec [file join $::quartus(binpath) quartus_sh] --version 2>@1]
if {[regexp -nocase {Lite Edition} $agm_version]} {
  error "AG32 requires preserved MCU design partitions. Quartus Lite removes them (138067). Use a supported licensed edition, or run build_logic.bat for Native synthesis."
}
set AGM_SUPRA true
set RETRY 0
set DESIGN "example_board"

if { [is_project_open] } {
  export_assignments
}

set is_compatible false
if { $is_compatible } {
  cd 
  qexec "[file join $::quartus(binpath) quartus_eda] $DESIGN --simulation --tool=modelsim --format=verilog"
} else {
  set FITTER_EFFORTS    {"STANDARD FIT" "STANDARD FIT" "FAST FIT" "FAST FIT" "FAST FIT"}
  set SEEDS             [list [expr int(rand()*100)] \
                              [expr int(rand()*100)] \
                              [expr int(rand()*100)] \
                              [expr int(rand()*100)] \
                              [expr int(rand()*100)]]
  set PLACEMENT_EFFORTS [list [expr rand()*5+0.1] \
                              [expr rand()*5+0.1] \
                              [expr rand()*5+0.1] \
                              [expr rand()*5+0.1] \
                              [expr rand()*5+0.1]]
  set    ROUTER_EFFORTS [list [expr rand()*5+0.25] \
                              [expr rand()*5+0.25] \
                              [expr rand()*5+0.25] \
                              [expr rand()*5+0.25] \
                              [expr rand()*5+0.25]]

  qexec "[file join $::quartus(binpath) quartus_sh] -t af_ip.tcl"

  load_package flow
  project_open $DESIGN

  set RETRY [expr $RETRY<[llength $FITTER_EFFORTS]?$RETRY:[llength $FITTER_EFFORTS]]
  for {set nn -1} {$nn < $RETRY} {incr nn} {
    if {$nn >= 0}  {
      set_global_assignment -name FITTER_EFFORT \"[lindex $FITTER_EFFORTS $nn]\"
      set_global_assignment -name SEED [lindex $SEEDS $nn]
      set_global_assignment -name PLACEMENT_EFFORT_MULTIPLIER [lindex $PLACEMENT_EFFORTS $nn]
      set_global_assignment -name    ROUTER_EFFORT_MULTIPLIER [lindex    $ROUTER_EFFORTS $nn]
    }

    set code [catch {execute_flow -compile} msg]
    if { $code == 0 } { break }
  }
}



# AGM_QUARTUS_RESULT_GUARD
if {!$is_compatible && $code != 0} {
  error "Quartus compilation failed: $msg"
}
set agm_report [file join quartus_logs ${DESIGN}.flow.rpt]
if {![file exists $agm_report]} {
  error "Quartus flow report is missing; no verified netlist was generated."
}
set agm_fp [open $agm_report r]
set agm_text [read $agm_fp]
close $agm_fp
if {![regexp {Total PLLs\s*;\s*([0-9]+)} $agm_text -> agm_plls] || $agm_plls < 1} {
  error "AG32 PLL was removed during synthesis. Do not compile or upload this Quartus netlist."
}
