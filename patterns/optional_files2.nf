

nextflow.enable.dsl=2

params.outdir = './output'
params.fastqc1_adapters         = 'NO_FILE'
params.fastqc1_contaminants     = 'NO_FILE'
params.fastqc2_adapters         = 'NO_FILE'
params.fastqc2_contaminants     = 'NO_FILE'
// params.fastqc2_adapters         = '/home/grace/work/pp/translation/nextflow/data/sequences1.txt'
// params.fastqc2_contaminants     = '/home/grace/work/pp/translation/nextflow/data/sequences2.txt'

// params.fastqc1_adapters         = null
// params.fastqc1_contaminants     = null
// params.fastqc2_adapters         = null
// params.fastqc2_contaminants     = null

fastqc1_adapters        = file( params.fastqc1_adapters )
fastqc1_contaminants    = file( params.fastqc1_contaminants )
// fastqc1_adapters     = params.fastqc1_adapters     ? file(params.fastqc1_adapters)     : file('NO_FILE')
// fastqc1_contaminants = params.fastqc1_contaminants ? file(params.fastqc1_contaminants) : file('NO_FILE_AB')

fastqc2_adapters        = file( params.fastqc2_adapters )
fastqc2_contaminants    = file( params.fastqc2_contaminants )


println fastqc1_adapters
println fastqc1_contaminants

workflow {

    // TASK1(
    //     fastqc1_adapters,
    //     fastqc1_contaminants,
    // )
    
    TASK2(
        fastqc2_adapters,
        fastqc2_contaminants,
    )

}


process TASK1 {
    input:
    path adapters, stageAs: 'adapters/*'
    path contaminants, stageAs: 'contaminants/*'

    output:
    stdout

    script: 
    def adapters = adapters.simpleName != 'NO_FILE' ? "wc -l ${adapters}" : ""
    def contaminants = contaminants.simpleName != 'NO_FILE' ? "wc -l ${contaminants}" : ""
    """
    ${adapters}
    ${contaminants}
    """
}
    // ${adapters}