


nextflow.enable.dsl=2

params.tumor_name = 'tumor'
params.normal_name = 'normal'

ch_tumor_name = Channel.of( params.tumor_name )
ch_normal_name = Channel.of( params.normal_name )


workflow {
    // TASK1('my job name')
    // TASK1("${ch_tumor_name.first()}--${ch_normal_name}")
    // def myvar = "${ch_tumor_name.first()}--${ch_normal_name.first()}"
    // def myvar = "$ch_tumor_name.first()--$ch_normal_name"
    // def myvar = ch_tumor_name.first() + '--' + ch_normal_name.first()
    // TASK1(myvar)
    
    TASK1(ch_tumor_name.first() + '--' + ch_normal_name.first())
    TASK1.out.view()
}

process TASK1 {
    input: 
    val job_name

    output:
    stdout

    script:
    """
    echo "${job_name}"
    """
}