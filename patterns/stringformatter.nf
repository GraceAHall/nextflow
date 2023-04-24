
nextflow.enable.dsl=2


// params.compression_level = null
params.compression_level = 5
// params.java_options = null
params.java_options = ['hello', 'there']


workflow {
    STP1('hello')
    STP1.out.view()
}


process STP1 {
    input:
    val mystr
    
    output:
    stdout

    script:
    def memory_val = 8 * 3 / 4
    def compression_val = params.compression_level ? '-Dsamjdk.compress_level=' + params.compression_level : ''
    def otherargs_val = [params.java_options, []].find{ it != null }.join(' ')
    """
    echo "--java-options -Xmx${memory_val}G ${compression_val} ${otherargs_val}"
    """
}