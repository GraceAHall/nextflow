
nextflow.enable.dsl=2

params.pos_basic       = ['../data/wildtype.fna', '../data/wildtype.fna.amb']
params.pos_default     = [100, 100]
params.pos_optional    = ['static', 'static']
params.flag_true       = [false, false]
params.flag_false      = [true, true]
params.opt_basic       = ['static', 'static']
params.opt_default     = [100, 100]
params.opt_optional    = ['hi', 'there']

// params.pos_basic       = ['../data/wildtype.fna', '../data/wildtype.fna.amb']
// params.pos_default     = null
// params.pos_optional    = null
// params.flag_true       = null
// params.flag_false      = null
// params.opt_basic       = ['static', 'static']
// params.opt_default     = null
// params.opt_optional    = null

ch_files = Channel.fromPath(params.pos_basic).collect()

workflow {
    COMPONENTS_ARRAY(ch_files).view{ it }
}

process COMPONENTS_ARRAY {
    publishDir './outputs'

    input:
    path pos_basic

    output: 
    stdout

    script:
    def pos_basic = pos_basic.join(' ')
    def pos_default = params.pos_default ? params.pos_default.join(',') : "95,95"
    def pos_optional = params.pos_optional ? params.pos_optional.join(' ') : ""
    def opt_basic = params.opt_basic.join(',')
    def opt_default = params.opt_default ? params.opt_default.join(' ') : "95 95"
    def opt_optional = params.opt_optional ? "--opt-optional=" + params.opt_optional.join(' ') : ""
    def opt_optional_prefixeach = params.opt_optional ? params.opt_optional.collect{ "--prefixeach " + it }.join(' ') : ""

    """
    echo \
    ${pos_basic} \
    ${pos_default} \
    ${pos_optional} \
    --opt-basic ${opt_basic} \
    --opt-default ${opt_default} \
    ${opt_optional} \
    ${opt_optional_prefixeach} \
    """ 
}