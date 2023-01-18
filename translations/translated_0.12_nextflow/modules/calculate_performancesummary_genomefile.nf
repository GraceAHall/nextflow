nextflow.enable.dsl=2

process CALCULATE_PERFORMANCESUMMARY_GENOMEFILE {
    debug true
    container "python@sha256:1d24b4656d4df536d8fa690be572774aa84b56c0418266b73886dc8138f047e6"
    publishDir "${params.outdir}/calculate_performancesummary_genomefile"

    input:
    path code_file
    tuple path(fasta), path(dict)

    output:
    path "out_out", emit: out

    script:
    """
    #!/usr/bin/env python

    from ${code_file.simpleName} import code_block
    import os
    import json

    result = code_block(reference="${fasta}", output_filename="genome_file.txt")

    work_dir = os.getenv("PYENV_DIR")
    for key in result:
        with open(os.path.join("${task.workDir}", f"out_{key}"), "w") as f:
            f.write(json.dumps(result[key]))
    """

}
