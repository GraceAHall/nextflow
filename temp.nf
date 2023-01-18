


process SECONDARIES_OLD {
    // janis: ToolInput("bams", BamBai())

    input:
    path bams  // [bam, bai]

    output: 
    stdout

    script:
    """
    gatk ${bams[0]}
    """

}

process SECONDARIES_NEW {
    // janis: ToolInput("bams", BamBai())

    input:
    tuple path(bam), path(bai)

    output: 
    stdout

    script:
    """
    gatk ${bam}
    """

}


