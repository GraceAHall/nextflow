
nextflow.enable.dsl=2

params.mystr = 'hello, there!'

workflow {
    PYTHON_TOOL().view()
    // ECHO(PYTHON_TOOL.out.out.split(',').collect()).view
}

process PYTHON_TOOL {
    publishDir './outputs'

    input:

    output: 
    val "${file("${task.workDir}/janis_out_mystr").text.split(',')}"

    script:
    """
    #!/usr/bin/env python
    with open('janis_out_mystr', 'w') as fp:
        fp.write('${params.mystr}')
    """ 
}

process ECHO {
    publishDir './outputs'

    input:
    val in_str

    output: 
    stdout

    script:
    """
    echo ${in_str}
    """ 
}