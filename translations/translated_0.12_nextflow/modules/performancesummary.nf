nextflow.enable.dsl=2

process PERFORMANCESUMMARY {
    debug true
    container "michaelfranklin/pmacutil@sha256:806f1bdcce8aa35baed9a64066878f77315fbd74b98c2bfc64cb5193dcf639c6"
    publishDir "${params.outdir}/performance_summary/performancesummary"

    input:
    path collectInsertSizeMetrics
    path coverage
    path flagstat
    path rmdupFlagstat
    val outputPrefix

    output:
    path "${'generated.csv' + '.csv'}", emit: out

    script:
    def rmdupFlagstat = rmdupFlagstat ? "--rmdup_flagstat ${rmdupFlagstat}" : ""
    def genome = params.performance_summary.performancesummary_genome == false ? "" : "--genome"
    """
    performance_summary.py \
    --collect_insert_metrics ${collectInsertSizeMetrics} \
    --coverage ${coverage} \
    --flagstat ${flagstat} \
    ${rmdupFlagstat} \
    -o ${outputPrefix} \
    ${genome} \
    """

}
