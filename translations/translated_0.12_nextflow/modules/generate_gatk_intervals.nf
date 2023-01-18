nextflow.enable.dsl=2

process GENERATE_GATK_INTERVALS {
    debug true
    container "python@sha256:1d24b4656d4df536d8fa690be572774aa84b56c0418266b73886dc8138f047e6"
    publishDir "${params.outdir}/generate_gatk_intervals"

    input:
    path code_file
    tuple path(fasta), path(dict)

    output:
    path "out_out_regions", emit: out_regions

    script:
    """
    #!/usr/bin/env python

    from ${code_file.simpleName} import code_block
    import os
    import json

    result = code_block(reference="${fasta}", prefix="chr", allowed_contigs=None, max_size=None, overlap=0, single_file=False)

    work_dir = os.getenv("PYENV_DIR")
    for key in result:
        with open(os.path.join("${task.workDir}", f"out_{key}"), "w") as f:
            f.write(json.dumps(result[key]))
    """

}
