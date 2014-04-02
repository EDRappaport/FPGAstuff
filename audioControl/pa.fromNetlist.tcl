
# PlanAhead Launch Script for Post-Synthesis floorplanning, created by Project Navigator

create_project -name audioControl -dir "/home/elli/Documents/Dropbox/The Cooper Union/Senior Project/FPGA/audioControl/planAhead_run_1" -part xc6slx9tqg144-2
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "/home/elli/Documents/Dropbox/The Cooper Union/Senior Project/FPGA/audioControl/main.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {/home/elli/Documents/Dropbox/The Cooper Union/Senior Project/FPGA/audioControl} {ipcore_dir} }
add_files [list {ipcore_dir/FIR.ncf}] -fileset [get_property constrset [current_run]]
add_files [list {ipcore_dir/musicStorage.ncf}] -fileset [get_property constrset [current_run]]
set_property target_constrs_file "constraints.ucf" [current_fileset -constrset]
add_files [list {constraints.ucf}] -fileset [get_property constrset [current_run]]
link_design
