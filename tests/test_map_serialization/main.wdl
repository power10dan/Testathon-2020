version 1.0
import "map_workflow.wdl" as map_wdl

workflow wf {
  call map_wdl.make_files as mk 

  Map[File, String] map_str = {mk.files[0]: "alice", mk.files[1]: "bob", mk.files[2]: "chuck"}
  Map[File, Int] map_int = {mk.files[0]: 1, mk.files[1]: 2, mk.files[2]: 3}
  Map[File, Boolean] map_bool = {mk.files[0]: true, mk.files[1]: false, mk.files[2]: false}
  
  call map_wdl.write_map as write_map {
        input: 
            file_to_name    = map_str,
            map_of_ints     = map_int,
            map_of_booleans = map_bool    
  }
  
  call map_wdl.read_map 
  
  output {
      File out_file_str  =   write_map.out1
      File out_file_int  =   write_map.out2
      File out_file_bool =  write_map.out3
  }
}
