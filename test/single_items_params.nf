

// these will be overridden by workflow params if exist
params.opt                         = 500
params.opt_optional                = 500
params.opt_default                 = 500
params.flag_true_default           = true
params.flag_false_default          = true

process SINGLE_ITEMS_PARAMS {
    input:
      path pos

    output:
      stdout
    
    script:
      def opt = params.opt
      def opt_optional = params.opt_optional ? "--min-length ${params.opt_optional}" : ""
      def opt_default = params.opt_default ?: '100'
      def flag_true_default = params.flag_true_default == false ? "" : "--trim-n"
      def flag_false_default = params.flag_false_default ? "--trim-n" : ""
      """
      echo --- SINGLES ---
      echo POSITIONAL: ${pos}
      echo OPTION: --min-length ${opt}
      echo OPTION_OPTIONAL: ${opt_optional}
      echo OPTION_DEFAULT: --min-length ${opt_default}
      echo FLAG_TRUE_DEFAULT: ${flag_true_default}
      echo FLAG_FALSE_DEFAULT: ${flag_false_default}
      """
}
