
nextflow.enable.dsl=2

params.mystr = 'hello there!'

workflow {
    PYTHON_TOOL().view()
}

process PYTHON_TOOL {
    publishDir './outputs'

    input:

    output: 
    path 'janis_out_mystr'

    script:
    """
    #!/usr/bin/env python
    with open('janis_out_mystr', 'w') as fp:
        fp.write("${params.mystr}")
    """ 
}