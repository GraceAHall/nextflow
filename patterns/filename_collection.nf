



workflow {
    MANDATORY('BRCA1')
    MANDATORY.out.out.view()
    OPTIONAL(Channel.of().ifEmpty( null ))
    OPTIONAL.out.out.view()
}

process MANDATORY {
    input: 
    val output_prefix

    output:
    path "${output_prefix + ".csv"}", emit: out

    script: 
    """
    touch ${output_prefix}.csv
    """
}

process OPTIONAL {
    input: 
    val output_prefix

    output:
    path "${(output_prefix ? output_prefix : "generated") + ".csv"}", emit: out

    script: 
    // new definition promises non-null value for output_prefix in script
    def output_prefix = output_prefix ? output_prefix : "generated" 
    println output_prefix
    """
    touch ${output_prefix}.csv
    """
}