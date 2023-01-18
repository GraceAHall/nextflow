
nextflow.enable.dsl=2

// params.pos_basic       = "../data/wildtype.fna"
// params.pos_default     = 100
// params.pos_optional    = 'static'
// params.flag_true       = false
// params.flag_false      = true
// params.opt_basic       = 'static'
// params.opt_default     = 100
// params.opt_optional    = ''

// params.pos_basic       = '../data/wildtype.fna'
params.pos_default     = null
params.pos_optional    = null
params.flag_true       = null
params.flag_false      = null
params.opt_basic       = 'static'
params.opt_default     = null
params.opt_optional    = null

ch_files = Channel.fromPath(params.components.pos_basic.ok)

workflow {
    COMPONENTS(ch_files).view{ it }
}

process COMPONENTS {
    publishDir './outputs'

    input:
    path pos_basic

    output: 
    stdout

    script:
    def pos_default = params.pos_default ? params.pos_default : 95
    def pos_optional = params.pos_optional ? params.pos_optional : ""
    def flag_true = params.flag_true == false ? "" : "--flag-true"
    def flag_false = params.flag_false ? "--flag-false" : ""
    def opt_default = params.opt_default ? params.opt_default : 5
    def opt_optional = params.opt_optional ? "--opt-optional ${params.opt_optional}" : ""

    """
    echo \
    ${pos_basic} \
    ${pos_default} \
    ${pos_optional} \
    ${flag_true} \
    ${flag_false} \
    --opt-basic ${params.opt_basic} \
    --opt-default ${opt_default} \
    ${opt_optional} \
    """ 
}