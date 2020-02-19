def test_map_literal(workflow_data, workflow_runner):
    expected = workflow_data.get_dict("out_file_int", "out_file_bool")
    input={}
    workflow_runner(
        "../main.wdl",
        input,
        expected,
        workflow_name="wf",
    )

