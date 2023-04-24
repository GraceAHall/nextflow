


process FASTQC {
    input: 
    path in_fastq

    output: 
    stdout

    script:
    """
    echo ${in_fastq}
    """
}