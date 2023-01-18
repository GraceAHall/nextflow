
nextflow.enable.dsl=2

params.python_code_file_path = '/home/grace/work/pp/translation/nextflow/patterns/code_file.py'


workflow {
    PYTHON_TOOL(
        params.python_code_file_path,
        'Hello',
        'Grace!',
    ).view()
}

process PYTHON_TOOL {

    input:
    path code_file
    val greet
    val name

    output:
    stdout

    script:
    """
    #!/usr/bin/env python

    from ${code_file.simpleName} import code_block
    code_block(
        greet="${greet}",
        name="${name}",
    )
    """
}