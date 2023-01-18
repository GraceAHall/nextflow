nextflow.enable.dsl=2

include { FASTQC } from './modules/fastqc'
include { GETFASTQC_ADAPTERS } from './modules/getfastqc_adapters'
include { ALIGN_AND_SORT } from './subworkflows/align_and_sort'
include { MERGE_AND_MARKDUPS } from './subworkflows/merge_and_markdups'
include { CALCULATE_PERFORMANCESUMMARY_GENOMEFILE } from './modules/calculate_performancesummary_genomefile'
include { PERFORMANCE_SUMMARY } from './subworkflows/performance_summary'
include { GENERATE_GATK_INTERVALS } from './modules/generate_gatk_intervals'
include { BQSR } from './subworkflows/bqsr'
include { VC_GATK } from './subworkflows/vc_gatk'
include { VC_GATK_MERGE } from './modules/vc_gatk_merge'
include { VC_GATK_SORT_COMBINED } from './modules/vc_gatk_sort_combined'
include { VC_GATK_UNCOMPRESS } from './modules/vc_gatk_uncompress'
include { VC_GATK_ADDBAMSTATS } from './subworkflows/vc_gatk_addbamstats'

ch_adapter_file     = Channel.fromPath( params.adapter_file )
ch_contaminant_file = Channel.fromPath( params.contaminant_file )
ch_fastqs           = Channel.fromPath( params.fastqs ).collect()
ch_known_indels     = Channel.fromPath( params.known_indels_gz, params.known_indels_tbi ).collect()
ch_mills_indels     = Channel.fromPath( params.mills_indels_gz, params.mills_indels_tbi ).collect()
ch_reference        = Channel.fromPath( params.reference_fasta, params.reference_amb, params.reference_ann, params.reference_bwt, params.reference_dict, params.reference_fai, params.reference_pac, params.reference_sa ).collect()
ch_snps_1000gp      = Channel.fromPath( params.snps_1000gp_gz, params.snps_1000gp_tbi ).collect()
ch_snps_dbsnp       = Channel.fromPath( params.snps_dbsnp_gz, params.snps_dbsnp_tbi ).collect()
ch_gatk_intervals   = Channel.fromPath( params.gatk_intervals ).collect().ifEmpty( null )


workflow  {

    FASTQC(
        ch_fastqs.flatten()
    )

    GETFASTQC_ADAPTERS(
        params.getfastqc_adapters.code_file,
        ch_adapter_file,
        ch_contaminant_file,
        FASTQC.out.out_R1_datafile,
        FASTQC.out.out_R2_datafile
    )

    ALIGN_AND_SORT(
        ch_fastqs.flatten(),
        ch_reference,
        params.sample_name,
        params.align_and_sort_sortsam_tmp_dir,
        GETFASTQC_ADAPTERS.out.out_R1_sequences.flatten(),
        GETFASTQC_ADAPTERS.out.out_R2_sequences.flatten()
    )

    MERGE_AND_MARKDUPS(
        ALIGN_AND_SORT.out.out,
        params.sample_name
    )

    CALCULATE_PERFORMANCESUMMARY_GENOMEFILE(
        params.calculate_performancesummary_genomefile.code_file,
        ch_reference
    )

    PERFORMANCE_SUMMARY(
        MERGE_AND_MARKDUPS.out.out,
        CALCULATE_PERFORMANCESUMMARY_GENOMEFILE.out.out,
        params.sample_name
    )

    GENERATE_GATK_INTERVALS(
        params.generate_gatk_intervals.code_file,
        ch_reference
    )

    BQSR(
        MERGE_AND_MARKDUPS.out.out,
        ch_known_indels,
        ch_mills_indels,
        ch_reference,
        ch_snps_1000gp,
        ch_snps_dbsnp,
        [ch_gatk_intervals.flatten(), GENERATE_GATK_INTERVALS.out.out_regions.flatten()].first()
    )

    VC_GATK(
        BQSR.out.out,
        ch_reference,
        ch_snps_dbsnp,
        [ch_gatk_intervals.flatten(), GENERATE_GATK_INTERVALS.out.out_regions.flatten()].first()
    )

    VC_GATK_MERGE(
        VC_GATK.out.out
    )

    VC_GATK_SORT_COMBINED(
        VC_GATK_MERGE.out.out
    )

    VC_GATK_UNCOMPRESS(
        VC_GATK_SORT_COMBINED.out.out
    )

    VC_GATK_ADDBAMSTATS(
        MERGE_AND_MARKDUPS.out.out,
        ch_reference,
        VC_GATK_UNCOMPRESS.out.out
    )


}
