

nextflow.enable.dsl=2

params.in_file = '/home/grace/work/pp/translation/nextflow/data/mutant_R1.fastq'
params.in_str = 'hello'
params.in_int = 5
params.multi_types_input_python_tool = '/home/grace/work/pp/translation/nextflow/patterns/templates/MultiTypesInputPythonTool.py'

ch_in_file = Channel.fromPath( params.in_file )

workflow {
    MULTI_TYPES_INPUT_PYTHON_TOOL(
        params.multi_types_input_python_tool,
        ch_in_file,
        params.in_str,
        params.in_int,
    )
    MULTI_TYPES_INPUT_PYTHON_TOOL.out.out.view()
}

process MULTI_TYPES_INPUT_PYTHON_TOOL {
    debug true
    container "python:3.8.1"

    input:
    path code_file
    path inp1, stageAs: 'inp1'
    val inp2
    val inp3

    output:
    val "${file("${task.workDir}/" + file("${task.workDir}/out_out").text.replace('"', ''))}", emit: out

    exec:

    script:
    """
    #!/usr/bin/env python

    from ${code_file.simpleName} import code_block
    import os
    import json

    result = code_block(
        inp1="${inp1}",
        inp2="${inp2}",
        inp3=${inp3},
    )

    work_dir = os.getcwd()
    for key in result:
        with open(os.path.join(work_dir, f"out_{key}"), "w") as fp:
            fp.write(json.dumps(result[key]))
    """

}