nextflow.enable.dsl=2

process GETFASTQC_ADAPTERS {
    debug true
    container "python@sha256:1d24b4656d4df536d8fa690be572774aa84b56c0418266b73886dc8138f047e6"
    publishDir "${params.outdir}/getfastqc_adapters"

    input:
    path code_file
    path adapters_lookup
    path contamination_lookup
    path read1_fastqc_datafile
    path read2_fastqc_datafile

    output:
    val "${file("${task.workDir}/out_out_R1_sequences").text.split(',')}", emit: out_R1_sequences
    val "${file("${task.workDir}/out_out_R2_sequences").text.split(',')}", emit: out_R2_sequences

    script:
    """
    #!/usr/bin/env python

    from ${code_file.simpleName} import code_block
    import os
    import json

    result = code_block(read1_fastqc_datafile="${read1_fastqc_datafile}", read2_fastqc_datafile="${read2_fastqc_datafile}", adapters_lookup="${adapters_lookup}", contamination_lookup="${contamination_lookup}")

    work_dir = os.getenv("PYENV_DIR")
    for key in result:
        with open(os.path.join("${task.workDir}", f"out_{key}"), "w") as f:
            f.write(json.dumps(result[key]))
    """

}
