version 1.0

task make_files {
  command {
  }
  output {
    Array[String] files = ["f1", "f2", "f3"]
  }
  runtime {
    docker: "python:3-slim"
  }
}

task write_map {
  input {
    Map[String, Int] map_of_ints 
    Map[String, Boolean] map_of_booleans
    # output files for each map type tests
    String out_file_two = "./output_map_of_ints.txt"
    String out_file_three = "./output_map_of_bools.txt"
  }
  command {
    cat ${write_map(map_of_ints)} > ~{out_file_two}
    echo ~{out_file_two}
    cat ${write_map(map_of_booleans)} > ~{out_file_three}
  }
  output {
    File out1 = out_file_two 
    File out2 = out_file_three 
  }
  runtime {
    docker: "python:3-slim"
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
    docker: "python:3-slim"
  }
}
