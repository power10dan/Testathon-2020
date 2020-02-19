version 1.0

task make_files {
  command {
    for f in f1 f2 f3; do touch $f; done
  }
  output {
    Array[File] files = ["f1", "f2", "f3"]
  }
  runtime {
    docker: "python:latest"
  }
}

task write_map {
  input {
    Map[File, String] file_to_name
    # Dan change: add serialization for 
    # type Map[File, Int] and Map[File, Bool]
    # to make write_map more comprehensive
    Map[File, Int] map_of_ints 
    Map[File, Boolean] map_of_booleans
    # output files for each map type tests
    String out_file = "./output_file_to_name.txt"
    String out_file_two = "./output_map_of_ints.txt"
    String out_file_three = "./output_map_of_bools.txt"
  }
  command {
    cat ${write_map(file_to_name)} > ~{out_file}
    cat ${write_map(map_of_ints)} > ~{out_file_two}
    cat ${write_map(map_of_booleans)} > ~{out_file_three}
  }
  output {
    File out1 = out_file 
    File out2 = out_file_two 
    File out3 = out_file_three 
  }
  runtime {
    docker: "python:latest"
  }
}

task read_map {
  command <<<
    python3 <<CODE
    map = {'x': 500, 'y': 600, 'z': 700}
    print("\\n".join(["{}\\t{}".format(k,v) for k,v in map.items()]))
    CODE
  >>>
  output {
    Map[String, Int] out_map = read_map(stdout())
  }
  runtime {
    docker: "python:latest"
  }
}
